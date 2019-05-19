require 'rails_helper'
RSpec.describe FetchNegotiations do
  let!(:recipient_negotiation) { create(:negotiation, type: 0) }
  let!(:delivery_negotiation) { create(:negotiation, type: 1) }
  let(:command) { described_class.run!(type: type) }

  context 'fetch recipients' do
    let(:type) { nil }

    it 'return 2 negotiation' do
      expect(command.count).to eq(2)
    end
  end

  context 'fetch recipients' do
    let(:type) { 0 }

    it 'return recipient' do
      expect(command.count).to eq(1)
      expect(command.first).to eq(recipient_negotiation)
    end
  end

  context 'fetch recipients' do
    let(:type) { 1 }

    it 'return recipient' do
      expect(command.count).to eq(1)
      expect(command.first).to eq(delivery_negotiation)
    end
  end
end
