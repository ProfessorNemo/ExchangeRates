# frozen_string_literal: true

RSpec.describe ExchangeRateDecorator, type: :decorator do
  let(:rate_at) { 30.days.from_now }
  let(:exchange_rate) { build(:exchange_rate, rate_at: rate_at) }
  let(:decorator) { exchange_rate.decorate }

  describe '#human_money' do
    it { expect(decorator.human_money.tr(',', '.')).to eq("#{exchange_rate.rate_value} руб.") }
  end

  describe '#rate_at_localtime' do
    context 'when rate at is blank' do
      let(:rate_at) { nil }

      it { expect(decorator.rate_at_localtime).to be_nil }
    end

    context 'when all is ok' do
      it do
        expect(decorator.rate_at_localtime)
          .to eq(rate_at.localtime.strftime('%d.%m.%Y %H:%M'))
      end
    end
  end
end
