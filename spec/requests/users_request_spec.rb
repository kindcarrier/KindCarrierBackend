require 'swagger_helper'

RSpec.describe 'Users', type: :request do
  path '/users' do
    post('User') do
      consumes 'application/json'
      tags 'Users'

      CREATING_EXAMPLE = {
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
          example: CREATING_EXAMPLE
        }
      }

      response '201', 'user created' do
        schema type: 'object', '$ref' => '#/definitions/user'
        let(:payload) { CREATING_EXAMPLE }
        run_test! do
          expect(json_response).to include(CREATING_EXAMPLE.as_json(only: %i[email first_name last_name]))
        end
      end
    end
  end

  path '/users/{id}' do
    put('User') do
      consumes 'application/json'
      tags 'Users'

      UPDATING_EXAMPLE = {
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name
      }.freeze

      parameter name: :payload, in: :body, required: true, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string }
        },
        example: UPDATING_EXAMPLE
      }

      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'user updated' do
        schema type: 'object', '$ref' => '#/definitions/user'

        let(:payload) { UPDATING_EXAMPLE }
        let(:user) { create(:user) }
        let(:id) { user.id }
        let(:authorization) { user.token }

        run_test! do
          expect(json_response).to include(UPDATING_EXAMPLE.as_json)
        end
      end
    end
  end
end
