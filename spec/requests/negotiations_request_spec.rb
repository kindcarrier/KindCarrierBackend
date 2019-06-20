require 'swagger_helper'

RSpec.describe 'Negotiations', type: :request do
  path '/negotiations' do
    post('Create negotiation') do
      consumes 'application/json'
      tags 'Negotiations'

      NEGOTIATION_CREATE_EXAMPLE = {
        name: 'Chezh beer',
        photo: 'test_photo.png',
        description: 'Wanna some authentic Czech beer',
        service_cost: 15,
        owner_id: 1,
        'type ': 'request',
        address_from: {
          country: 'Chezh',
          city: 'Prague',
          state: 'Hlavni mesto Praha',
          street: 'Podbelohorska',
          latitude: 50,
          longitude: 70
        },
        address_to: {
          country: 'Russia',
          city: 'Barnaul',
          state: 'Altay kray',
          street: 'Pionerskaya dolina',
          latitude: 80,
          longitude: 95
        }
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
          type: { type: :string },
          address_from: {
            type: :object,
            'x-nullable': true,
            properties: {
              country: { type: :string, 'x-nullable': true },
              city: { type: :string, 'x-nullable': true },
              state: { type: :string, 'x-nullable': true },
              street: { type: :string, 'x-nullable': true },
              latitude: { type: :number, 'x-nullable': true },
              longitude: { type: :number, 'x-nullable': true }
            },
            required: %w[country city state street latitude longitude]
          },
          address_to: {
            type: :object,
            'x-nullable': true,
            properties: {
              country: { type: :string, 'x-nullable': true },
              city: { type: :string, 'x-nullable': true },
              state: { type: :string, 'x-nullable': true },
              street: { type: :string, 'x-nullable': true },
              latitude: { type: :number, 'x-nullable': true },
              longitude: { type: :number, 'x-nullable': true }
            },
            required: %w[country city state street latitude longitude]
          },
          owner_id: { type: :integer },
          required: %w[name photo description service_cost country
                       city state street latitude_from longitude_from latitude_to
                       longitude_to type],
          example: NEGOTIATION_CREATE_EXAMPLE
        }
      }

      parameter name: :authorization, in: :header, type: :string, required: true

      response '201', 'negotiation created' do
        schema type: 'object', '$ref' => '#/definitions/negotiation'

        let(:user) { create(:user, id: 1) }
        let(:authorization) { user.token }
        let(:payload) { NEGOTIATION_CREATE_EXAMPLE }

        run_test! do
          expect(json_response['name']).to eq('Chezh beer')
        end
      end

      response '401', 'Unauthorized' do
        let(:authorization) { 'non_existing_token' }
        let(:payload) { NEGOTIATION_CREATE_EXAMPLE }

        run_test!
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

      let(:owner) { create(:user) }
      let(:negotiation) { create(:negotiation, owner: owner) }
      let(:id) { negotiation.id }
      let(:accepter) { create(:user) }

      response '200', 'negotiation confirmed successfully' do
        schema type: 'object', '$ref' => '#/definitions/negotiation'

        let(:authorization) { accepter.token }

        run_test! do
          expect(json_response['status']).to eq('confirmed')
          expect(json_response['accepter_id']).to eq(accepter.id)
        end
      end

      response '401', 'Unauthorized' do
        let(:authorization) { 'no' }

        run_test!
      end

      # TODO: refactor to 422 status
      # TODO add schema checkers for errors
      response '500', 'Wrong parameters' do
        context 'user is owner of negotiation' do
          let(:authorization) { owner.token }

          run_test!
        end

        context 'negotiation is confirmed already' do
          let(:negotiation) { create(:negotiation, owner: owner, status: :confirmed) }
          let(:authorization) { accepter.token }

          run_test!
        end
      end
    end
  end

  path '/negotiations/{id}/cancel' do
    put('Cancel negotiation') do
      consumes 'application/json'
      tags 'Negotiations'

      parameter name: :id, in: :path, type: :string, required: true, example: 1
      parameter name: :authorization, in: :header, type: :string, required: true

      let(:owner) { create(:user) }
      let(:accepter) { create(:user) }
      let(:negotiation) { create(:negotiation, owner: owner, accepter: accepter, status: 'confirmed') }
      let(:id) { negotiation.id }

      response '200', 'negotiation confirmed successfully' do
        schema type: 'object', '$ref' => '#/definitions/negotiation'

        context 'cancelator is owner' do
          let(:authorization) { owner.token }

          run_test! do
            expect(json_response['status']).to eq('canceled')
          end
        end

        context 'cancelator is accepter' do
          let(:authorization) { accepter.token }

          run_test! do
            expect(json_response['status']).to eq('canceled')
          end
        end
      end

      response '401', 'Unauthorized' do
        let(:authorization) { 'no' }

        run_test!
      end

      # TODO: refactor to 422 status
      response '500', 'Wrong parameters' do
        context 'cancelator is not owner nor accepter' do
          let(:some_user) { create(:user) }
          let(:authorization) { some_user.token }

          run_test!
        end

        context 'negotiation is not confirmed' do
          let(:negotiation) { create(:negotiation, owner: owner, accepter: accepter, status: :opened) }
          let(:authorization) { accepter.token }

          run_test!
        end
      end
    end
  end
end
