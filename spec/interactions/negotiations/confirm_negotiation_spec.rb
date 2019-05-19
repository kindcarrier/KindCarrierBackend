require 'rails_helper'

RSpec.describe ConfirmNegotiation do
  let(:accepter) { create(:user) }
  let(:owner) { create(:user) }
  let(:negotiation) do
    create(:negotiation, owner_id: owner.id, accepter_id: accepter.id)
  end
  let(:command) { described_class.run!(negotiation: negotiation, user: accepter) }

  it 'change negotiation status' do
    expect(command).to have_attributes(id: negotiation.id, status: 'confirmed')
  end
end
