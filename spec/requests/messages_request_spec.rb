require 'swagger_helper'

RSpec.describe 'Messages', type: :request do
  path '/messages/{id}' do
    post('Create message') do
      consumes 'application/json'
      tags 'Message'

      MESSAGE_CREATE_EXAMPLE = {
        negotiation_id: 1,
        text: 'Message\'s text'
      }.freeze

      parameter name: :payload, in: :body, required: true, schema: {
        type: :object,
        properties: {
          negotiation_id: { type: :integer },
          text: { type: :string },
          required: %w[negotiation_id text],
          example: MESSAGE_CREATE_EXAMPLE
        }
      }

      parameter name: :authorization, in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true, example: 1

      let(:accepter) { create(:user) }
      let(:owner) { create(:user) }
      let(:negotiation) { create(:negotiation, accepter: accepter, owner: owner, id: 1) }
      let(:id) { negotiation.id }
      let(:payload) { MESSAGE_CREATE_EXAMPLE }
      let(:authorization) { owner.token }

      response '201', 'Message created' do
        schema type: 'object', '$ref' => '#/definitions/message'

        let(:user) { owner }

        run_test! do
          expect(json_response['text']).to eq('Message\'s text')
        end
      end

      response '401', 'Unauthorized' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:authorization) { 'non_existing_token' }

        run_test!
      end

      response '404', 'No negotiation found' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:id) { 0 }

        run_test!
      end
    end

    get('Fetch messages') do
      consumes 'application/json'
      tags 'Messages'

      parameter name: :authorization, in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true, example: 1

      let(:accepter) { create(:user) }
      let(:owner) { create(:user) }
      let(:negotiation) { create(:negotiation, accepter: accepter, owner: owner) }
      let!(:accepter_messages) { create_list(:message, 3, user: accepter, negotiation: negotiation) }
      let!(:owner_messages) { create_list(:message, 3, user: owner, negotiation: negotiation) }
      let(:id) { negotiation.id }

      response '200', 'Fetch messages successfully' do
        schema type: :array, items: { '$ref': '#/definitions/message' }

        context 'accepter requests' do
          let(:authorization) { accepter.token }

          run_test! do
            expect(json_response).to be
            expect(json_response.count).to eq(6)
          end
        end

        context 'owner requests' do
          let(:authorization) { owner.token }

          run_test! do
            expect(json_response).to be
            expect(json_response.count).to eq(6)
          end
        end
      end

      response '422', 'No negotiation found' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:authorization) { random_user.token }
        let(:random_user) { create(:user) }

        run_test!
      end

      response '404', 'No negotiation found' do
        schema type: 'object', '$ref' => '#/definitions/error'

        let(:authorization) { owner.token }
        let(:id) { 0 }

        run_test!
      end
    end
  end
end
