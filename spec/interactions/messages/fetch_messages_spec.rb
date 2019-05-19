require 'rails_helper'

RSpec.describe FetchMessages do
  let(:owner) { create(:user) }
  let(:accepter) { create(:user) }
  let(:negotiation) do
    create(:negotiation, accepter_id: accepter.id, owner_id: owner.id)
  end

  let!(:owner_message) do
    create(:message,
      user: owner,
      negotiation: negotiation,
      created_at: Time.current)
  end
  let!(:accepter_message) do
    create(:message,
      user: accepter,
      negotiation: negotiation,
      created_at: Time.current + 1.hour)
  end

  let(:command) do
    described_class.run!(negotiation_id: negotiation.id, user: accepter)
  end

  it 'return 2 messages' do
    expect(command).to include(owner_message, accepter_message)
  end
end
