require 'swagger_helper'

RSpec.describe 'Users', type: :request do
  path '/users' do
    post('User') do
      consumes 'application/json'
      tags 'Users'

      EXAMPLE = {
        email: FFaker::Internet.email,
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name,
        password: FFaker::Internet.password
      }.freeze

      parameter name: :payload, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          first_name: { type: :string },
          last_name: { type: :string },
          password: { type: :string },
          required: %w[email password first_name last_name],
          example: EXAMPLE
        }
      }

      response '201', 'user created' do
        schema type: 'object', '$ref' => '#/definitions/user'
        let(:payload) { EXAMPLE }
        run_test! do
          expect(json_response).to include(EXAMPLE.as_json(only: %i[email first_name last_name]))
        end
      end
    end
  end
end
