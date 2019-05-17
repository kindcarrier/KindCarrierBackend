# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Session', type: :request, capture_examples: true do
  path '/session' do
    post('Sign in user') do
      consumes 'application/json'
      tags 'Users'

      USER_EXAMPLE = {
        email: 'john@brown',
        password: '123456'
      }.freeze

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password],
        example: USER_EXAMPLE
      }

      response '200', 'user successfully signed in' do
        schema type: 'object', '$ref' => '#/definitions/user'
        let!(:user) { create(:user, USER_EXAMPLE) }
        let(:credentials) { USER_EXAMPLE }
        run_test! do
          expect(json_response['email']).to eq user.email
          expect(json_response['token']).to eq user.token
        end
      end
    end
  end
end
