# frozen_string_literal: true

# rubocop:disable all
RSpec.describe ExchangeRate do
  describe 'validations' do
    let(:exchange_rate) { build(:exchange_rate) }

    it { expect(exchange_rate).to validate_presence_of(:currency) }
    it { expect(exchange_rate).to validate_presence_of(:rate_at) }
    it { expect(exchange_rate).to validate_presence_of(:rate_value) }
    it { expect(exchange_rate).to validate_numericality_of(:rate_value).is_greater_than_or_equal_to(0) }

    context 'when currency does not exist' do
      it { expect { exchange_rate.currency = 'EUR' }.to raise_error(ArgumentError) }
    end

    context 'when rate at is invalid' do
      it do
        expect(exchange_rate)
          .not_to allow_value('13', 'a/b/c', '1380', '2000-120-12', '1533-15-19', '13-08-99').for(:rate_at)
      end
    end
  end

  describe 'after commit' do
    let!(:exchange_rate) { create(:exchange_rate) }
    let(:exchange_rate_dispatch) { double('ExchangeRates::Dispatch')  }

    before do
      allow(ExchangeRates::Dispatch).to receive(:new).with(exchange_rate).and_return(exchange_rate_dispatch)
      allow(exchange_rate_dispatch).to receive(:perform)

      allow(Resque).to receive(:remove_delayed).with(RateJob, force: true)
      allow(Resque).to receive(:enqueue_at).with(exchange_rate.rate_at, RateJob, force: true)

      exchange_rate.update!(rate_value: 70)
    end

    it { expect(exchange_rate_dispatch).to have_received(:perform) }
    it { expect(Resque).to have_received(:remove_delayed) }
    it { expect(Resque).to have_received(:enqueue_at) }
  end
end
# rubocop:enable all
