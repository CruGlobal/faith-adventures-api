# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it { is_expected.to validate_presence_of(:sub) }
  it { is_expected.to validate_uniqueness_of(:sub) }
  it { is_expected.to have_many(:memberships).dependent(:delete_all) }
  it { is_expected.to have_many(:views).dependent(:delete_all) }
  it { is_expected.to have_many(:likes).dependent(:delete_all) }
  it { is_expected.to have_many(:dislikes).dependent(:delete_all) }
  it { is_expected.to have_many(:adventures).through(:memberships) }
  it { is_expected.to have_many(:steps).through(:adventures) }

  describe '.from_token' do
    let(:attributes) do
      {
        'iss' => 'https://securetoken.google.com/firebase-id-token',
        'name' => 'Ugly Bob',
        'picture' => 'https://someurl.com/photo.jpg',
        'aud' => 'firebase-id-token',
        'auth_time' => 1_492_981_192,
        'user_id' => 'theUserID',
        'sub' => 'theUserID',
        'iat' => 30.minutes.ago.to_i,
        'exp' => 30.minutes.from_now.to_i,
        'email' => 'uglybob@emailurl.com',
        'email_verified' => true,
        'firebase' => {
          'identities' => {
            'google.com' => [
              '1010101010101010101'
            ],
            'email' => [
              'uglybob@emailurl.com'
            ]
          },
          'sign_in_provider' => 'google.com'
        }
      }
    end
    let(:token) do
      JWT.encode attributes, OpenSSL::PKey::RSA.new(FirebaseIdToken::Testing::Certificates.private_key), 'RS256'
    end

    before { FirebaseIdToken.test! }

    it 'creates user' do
      expect(described_class.from_token(token).attributes).to include attributes.slice(
        'sub', 'name', 'picture', 'email', 'email_verified'
      )
    end

    context 'when user exists' do
      subject!(:user) { create(:user, sub: 'theUserID') }

      it 'returns user' do
        expect(described_class.from_token(token).attributes).to include attributes.slice(
          'sub', 'name', 'picture', 'email', 'email_verified'
        )
      end

      it 'does not create user' do
        expect { described_class.from_token(token) }.not_to change(described_class, :count)
      end
    end
  end
end
