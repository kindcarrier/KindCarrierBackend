require 'swagger_helper'

RSpec.describe 'Negotiations', type: :request do
  path '/negotiations' do
    post('Create negotiation') do
      consumes 'application/json'
      tags 'Negotiations'

      NEGOTIATION_CREATE_EXAMPLE = {
        name: 'Chezh beer',
        photo: 'test_photo.png', # TODO: use image file faker
        description: 'Wanna some authentic Czech beer',
        service_cost: 15,
        country: 'Chezh',
        city: 'Prague',
        state: 'Hlavni mesto Praha',
        street: 'Podbelohorska',
        latitude_from: 50.075455,
        longitude_from: 14.371850,
        latitude_to: 53.36056,
        longitude_to: 83.76361,
        type: 'request',
        owner_id: 1
      }.freeze

      parameter name: :payload, in: :body, required: true, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          photo: { type: :string },
          description: { type: :string },
          service_cost: { type: :string },
          country: { type: :string },
          city: { type: :string },
          state: { type: :string },
          street: { type: :string },
          latitude_from: { type: :number },
          longitude_from: { type: :number },
          latitude_to: { type: :number },
          longitude_to: { type: :number },
          type: { type: :string },
          user_id: { type: :integer },
          required: %w[name photo description service_cost country
                       city state street latitude_from longitude_from latitude_to
                       longitude_to type user],
          example: NEGOTIATION_CREATE_EXAMPLE
        }
      }

      parameter name: :authorization, in: :header, type: :string, required: true

      response '201', 'negotiation created' do
        # schema type: 'object', '$ref' => '#/definitions/negotiation'

        let(:user) { create(:user, id: 1) }
        let(:authorization) { user.token }
        let(:payload) { NEGOTIATION_CREATE_EXAMPLE }

        run_test! do
          binding.pry
          #   expect(json_response).to include(EXAMPLE.as_json(only: %i[email first_name last_name]))
        end
      end

      response '401', 'Unauthorized' do
        # schema type: 'object', '$ref' => '#/definitions/error'

        let(:authorization) { 'non_existing_token' }
        let(:payload) { NEGOTIATION_CREATE_EXAMPLE }

        run_test! do
          bindind.pry
        end
      end
    end

    get('Fetch negotiations') do
      consumes 'application/json'
      tags 'Negotiations'

      response '200', 'open negotiations got successfully' do
        schema type: :array, items: { '$ref': '#/definitions/negotiation' }

        let!(:negotiations) { create_list(:negotiation, 4) }
        let!(:confirmed_negotiation) { create(:negotiation, status: :confirmed) }
        let!(:canceled_negotiation) { create(:negotiation, status: :canceled) }

        run_test! do
          expect(json_response).to be
          expect(json_response.count).to eq(4)
        end
      end
    end
  end

  path '/negotiations/{id}/confirm' do
    put('Confirm negotiation') do
      consumes 'application/json'
      tags 'Negotiations'

      parameter name: :id, in: :path, type: :string, required: true, example: 1
      parameter name: :authorization, in: :header, type: :string, required: true

      response '200', 'negotiation confirmed successfully' do
        schema type: 'object', '$ref' => '#/definitions/negotiation'

        let(:owner) { create(:user) }
        let(:negotiation) { create(:negotiation, owner: owner) }
        let(:id) { negotiation.id }
        let(:accepter) { create(:user) }
        let(:authorization) { accepter.token }

        run_test! do
          binding.pry
        # expect(json_response[:status]).to eq(:confirmed)
        # expect(json_response[:accepter][:id]).to eq(accepter.id)
        end
      end
      
      response '401', 'Unauthorized' do
        # schema type: 'object', '$ref' => '#/definitions/negotiation'

        let(:negotiation) { create(:negotiation) }
        let(:id) { negotiation.id }
        let(:accepter) { create(:user) }
        let(:authorization) { accepter.token }

        run_test! do
          binding.pry
        # expect(json_response[:status]).to eq(:confirmed)
        # expect(json_response[:accepter][:id]).to eq(accepter.id)
        end
      end
    end
  end
end
