require 'rails_helper'

RSpec.describe CancelNegotiation do
  let(:accepter) { create(:user) }
  let(:negotiation) do
    create(:negotiation, accepter_id: accepter.id)
  end
  let(:command) { described_class.run!(negotiation: negotiation, user: accepter) }

  it 'change negotiation status' do
    expect(command).to have_attributes(id: negotiation.id, status: 'canceled')
  end
end
