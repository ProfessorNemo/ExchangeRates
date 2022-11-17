# frozen_string_literal: true

RSpec.describe ExchangeRates::Parser, type: :service do
  let(:url) { 'http://www.cbr.ru/scripts/XML_daily.asp' }
  let!(:exchange_rate) { create(:exchange_rate) }
  let(:force) { true }
  let(:service) { described_class.new(exchange_rate, force) }

  let(:body) do
    <<-XML
      <?xml version="1.0" encoding="windows-1251"?>
      <ValCurs Date="12.11.2022" name="Foreign Currency Market">
        <Valute ID="R01235">
          <NumCode>840</NumCode>
          <CharCode>USD</CharCode>
          <Nominal>1</Nominal>
          <Name>Доллар США</Name>
          <Value>60,2179</Value>
        </Valute>
        <Valute ID="R01239">
          <NumCode>978</NumCode>
          <CharCode>EUR</CharCode>
          <Nominal>1</Nominal>
          <Name>Евро</Name>
          <Value>61,5416</Value>
        </Valute>
      </ValCurs>
    XML
  end

  shared_examples 'force or not force' do
    context 'when api url does not exist' do
      let(:url) { 'http://does not exist' }

      before do
        stub_request(:get, url)
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v1.10.2'
            }
          )
          .to_return(status: 200, body: '', headers: {})
      end

      before { stub_const('ExchangeRates::Parser::URL', url) }

      it { expect { service.call }.to raise_error(RuntimeError, 'Не удалось получить данные с сервера') }
    end

    context 'when response is ok' do
      before do
        stub_request(:get, url)
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v1.10.2'
            }
          )
          .to_return(status: 200, body: '', headers: {})
      end

      context 'when body is blank' do
        let(:body) { '' }

        it { expect { service.call }.to raise_error(RuntimeError, 'Не удалось получить данные с сервера') }
      end

      context 'when body is present' do
        let(:dispatch_mock) { instance_double(ExchangeRates::Dispatch) }

        before do
          allow(ExchangeRates::Dispatch).to receive(:new)
            .with(exchange_rate)
            .and_return(dispatch_mock)
        end

        before { allow(dispatch_mock).to receive(:call) }

        it { expect { service.call }.to change { exchange_rate.reload.rate_value }.from(62.05).to(60.2179) }

        it do
          service.call

          expect(dispatch_mock).to have_received(:call)
        end
      end
    end
  end

  describe '#call' do
    context 'when not force' do
      let(:force) { false }

      context 'when exchange rate at is more than current time' do
        it { expect(service.call).to be_nil }
      end

      context 'when exchange rate at is less than current time' do
        let(:rate_at) { 5.days.ago }
        let(:exchange_rate) { build(:exchange_rate, rate_at: rate_at) }
        let(:dispatch_mock) { instance_double(ExchangeRates::Dispatch) }

        before do
          allow(ExchangeRates::Dispatch).to receive(:new)
            .with(exchange_rate)
            .and_return(dispatch_mock)
        end

        before { allow(dispatch_mock).to receive(:call) }

        before do
          stub_request(:get, url)
            .with(
              headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent' => 'Faraday v1.10.2'
              }
            )
            .to_return(status: 200, body: '', headers: {})
        end

        before { exchange_rate.save(validate: false) }

        it { expect { service.call }.to raise_error(RuntimeError, 'Не удалось получить данные с сервера') }

        it { expect(dispatch_mock).not_to have_received(:call) }
      end
    end
  end
end
