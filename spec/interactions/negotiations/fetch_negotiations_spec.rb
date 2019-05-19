require 'rails_helper'
RSpec.describe FetchNegotiations do
  let!(:request_negotiation) { create(:negotiation, type: 'request') }
  let!(:offer_negotiation) { create(:negotiation, type: 'offer') }
  let(:command) { described_class.run!(type: type) }

  context 'fetch all negotiations' do
    let(:type) { nil }

    it 'return 2 negotiation' do
      expect(command.count).to eq(2)
    end
  end

  context 'fetch requests' do
    let(:type) { 'request' }

    it 'return request' do
      expect(command.count).to eq(1)
      expect(command.first).to eq(request_negotiation)
    end
  end

  context 'fetch offers' do
    let(:type) { 'offer' }

    it 'return offer' do
      expect(command.count).to eq(1)
      expect(command.first).to eq(offer_negotiation)
    end
  end
end
