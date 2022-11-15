# frozen_string_literal: true

# rubocop:disable all
RSpec.describe ExchangeRates::Dispatch, type: :service do
  let!(:exchange_rate) { create(:exchange_rate).decorate }
  let(:service) { described_class.new(exchange_rate) }
  let(:broadcast_mock) { double('ActionCable') }

  describe '#call' do
    before do
      allow(ActionCable).to receive(:server).and_return(broadcast_mock)
      allow(broadcast_mock)
        .to receive(:broadcast).with('rate_channel', { rate_value: exchange_rate.human_money })

      service.perform
    end

    it { expect(broadcast_mock).to have_received(:broadcast) }
  end
end
# rubocop:enable all
