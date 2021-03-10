# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::MeQuery, type: :query do
  let(:user) { create(:user, :complete) }
  let(:data) do
    {
      'me' => {
        'id' => user.id,
        'givenName' => user.given_name,
        'familyName' => user.family_name,
        'nickname' => user.nickname,
        'name' => user.name,
        'picture' => user.picture,
        'locale' => user.locale,
        'email' => user.email,
        'emailVerified' => user.email_verified,
        'admin' => user.has_role?(:admin)
      }
    }
  end

  it 'return user' do
    resolve(query, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when admin' do
    before { user.add_role(:admin) }

    it 'return user' do
      resolve(query, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when no current_user' do
    it 'returns error' do
      resolve(query)
      expect(response_errors[0]['extensions']['code']).to eq('UNAUTHORIZED'), invalid_response_data
    end
  end

  def query
    <<~GQL
      query {
        me {
          id
          givenName
          familyName
          nickname
          name
          picture
          locale
          email
          emailVerified
          admin
        }
      }
    GQL
  end
end
