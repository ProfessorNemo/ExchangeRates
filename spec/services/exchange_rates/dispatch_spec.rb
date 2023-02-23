# frozen_string_literal: true

# rubocop:disable all
RSpec.describe ExchangeRates::Dispatch, type: :service do
  let!(:exchange_rate) { create(:exchange_rate).decorate }
  let(:service) { described_class.new(exchange_rate) }
  let(:broadcast_mock) { instance_double Turbo::StreamsChannel }

  describe '#call' do
    before do
      allow(Turbo::StreamsChannel)
        .to receive(:broadcast_action_to).with('money',
                               action: 'update',
                               target: 'currency',
                               content: ApplicationController.render(
                                        template: 'currencies/updated',
                                        locals: { exchange_rate: exchange_rate },
                                        layout: false
                                     )).and_return(broadcast_mock)

      service.call
    end

    it { expect(Turbo::StreamsChannel).to have_received(:broadcast_action_to) }
  end
end
# rubocop:enable all
