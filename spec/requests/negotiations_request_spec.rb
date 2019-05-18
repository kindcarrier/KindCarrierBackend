# require 'swagger_helper'

# RSpec.describe 'Negotiations', type: :request do
#   path '/negotiations' do
#     post('Negotiation') do
#       consumes 'application/json'
#       tags 'Negotiations'
#       let(:user) { create(:user) }

#       EXAMPLE = {
#         name: 'name',
#         photo: 'test_photo.png',
#         description: 'description',
#         service_cost: 15,
#         country: 'country',
#         city: 'city',
#         state: 'state',
#         street: 'street',
#         latitude_from: 30,
#         longitude_from: 45,
#         latitude_to: 40,
#         longitude_to: 50,
#         type: 0,
#         user_id: user.id
#       }.freeze

#       parameter name: :payload, in: :body, required: true, schema: {
#         type: :object,
#         properties: {
#           name: { type: :string },
#           photo: { type: :string },
#           description: { type: :string },
#           service_cost: { type: :string },
#           country: { type: :string },
#           city: { type: :string },
#           state: { type: :string },
#           street: { type: :string },
#           latitude_from: { type: :number },
#           longitude_from: { type: :number },
#           latitude_to: { type: :number },
#           longitude_to: { type: :number },
#           type: { type: :integer },
#           user_id: { type: :integer },
#           required: %w[name photo description service_cost country
#             city state street latitude_from longitude_from latitude_to
#             longitude_to type user],
#           example: EXAMPLE
#         }
#       }

#       response '201', 'negotiation created' do
#         schema type: 'object', '$ref' => '#/definitions/user'
#         let(:payload) { EXAMPLE }
#         before(:each) { expect(CreateUser).to receive(:run!).and_call_original }
#         run_test! do
#           expect(json_response).to include(EXAMPLE.as_json(only: %i[email first_name last_name]))
#         end
#       end
#     end
#   end
# end
