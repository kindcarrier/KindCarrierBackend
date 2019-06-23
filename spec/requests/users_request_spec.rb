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

      response '422', 'Invalid data' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:payload) { CREATING_EXAMPLE.merge(password: nil) }
        run_test!
      end
    end

    get('Fetch users') do
      consumes 'application/json'
      tags 'Users'

      parameter name: :authorization, in: :header, type: :string, required: true

      let(:current_user) { create(:user) }
      let!(:users) { create_list(:user, 2) }

      response '200', 'get users' do
        schema type: :array, items: { '$ref': '#/definitions/user' }

        let(:authorization) { current_user.token }

        run_test! do
          expect(json_response).to be
          expect(json_response.count).to eq(3)
        end
      end

      response '401', 'Unauthorized' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:authorization) { 'wrong' }

        run_test!
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

      response '200', 'User is updated' do
        schema type: 'object', '$ref' => '#/definitions/user'

        let(:payload) { UPDATING_EXAMPLE }
        let(:user) { create(:user) }
        let(:id) { user.id }
        let(:authorization) { user.token }

        run_test! do
          expect(json_response).to include(UPDATING_EXAMPLE.as_json)
        end
      end

      response '401', 'Unauthorized' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:user) { create(:user) }
        let(:id) { user.id }
        let(:payload) { UPDATING_EXAMPLE }
        let(:authorization) { 'wrong' }

        run_test!
      end

      response '422', 'Invalid data' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:payload) { UPDATING_EXAMPLE.merge(first_name: nil) }
        let(:user) { create(:user) }
        let(:id) { user.id }
        let(:authorization) { user.token }

        run_test!
      end
    end

    get('Fetch user') do
      consumes 'application/json'
      tags 'Users'

      parameter name: :authorization, in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true

      let(:current_user) { create(:user) }
      let!(:users) { create_list(:user, 2) }
      let(:id) { users.first.id }
      let(:authorization) { current_user.token }

      response '200', 'Get user by id' do
        schema type: 'object', '$ref' => '#/definitions/user'

        run_test! do
          expect(json_response['id']).to eq(id)
        end
      end

      response '401', 'Unauthorized' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:authorization) { 'wrong' }

        run_test!
      end

      response '404', 'Wrong id' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:id) { 0 }

        run_test!
      end
    end
  end
end
