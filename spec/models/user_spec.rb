# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it { is_expected.to validate_presence_of(:sub) }
  it { is_expected.to validate_uniqueness_of(:sub) }

  describe '.from_token' do
    subject(:user) { described_class.find_by(sub: '248289761001') }

    let(:attributes) do
      {
        'sub' => '248289761001',
        'name' => 'Jane Josephine Doe',
        'given_name' => 'Jane',
        'family_name' => 'Doe',
        'middle_name' => 'Josephine',
        'nickname' => 'JJ',
        'preferred_username' => 'j.doe',
        'profile' => 'http://exampleco.com/janedoe',
        'picture' => 'http://exampleco.com/janedoe/me.jpg',
        'website' => 'http://exampleco.com',
        'email' => 'janedoe@exampleco.com',
        'email_verified' => true,
        'gender' => 'female',
        'birthdate' => '1972-03-31',
        'zoneinfo' => 'America/Los_Angeles',
        'locale' => 'en-US',
        'phone_number' => '+1 (111) 222-3434',
        'phone_number_verified' => false,
        'address' => {
          'country' => 'us'
        }
      }
    end

    before do
      allow(User::JsonWebTokenService).to receive(:verify).with('token').and_return({ 'sub' => '248289761001' })
      stub_request(:get, 'https://example.com/userinfo')
        .with(headers: { 'Authorization' => 'Bearer token' })
        .and_return(headers: { 'Content-Type' => 'application/json' }, body: attributes.to_json)
    end

    it 'creates user' do
      expect(described_class.from_token('token').attributes).to include attributes.slice(
        'sub', 'given_name', 'family_name', 'nickname', 'name', 'picture', 'locale', 'email', 'email_verified'
      )
    end

    context 'when user exists' do
      subject!(:user) { create(:user, sub: '248289761001') }

      it 'returns user' do
        expect(described_class.from_token('token')).to eq user
      end
    end
  end
end
