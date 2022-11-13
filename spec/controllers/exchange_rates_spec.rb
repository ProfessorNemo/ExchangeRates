# frozen_string_literal: true

RSpec.describe ExchangeRatesController do
  describe '#edit' do
    context 'when format is invalid' do
      it { expect { get(:edit, format: :json) }.to raise_error(ActionController::UnknownFormat) }
    end

    context 'when all is ok' do
      before { get :edit }

      it { expect(response).to have_http_status :ok }
    end
  end

  describe '#update' do
    let!(:exchange_rate) { create(:exchange_rate) }

    context 'when param is missing' do
      it { expect { put(:update) }.to raise_error(ActionController::ParameterMissing) }
    end

    context 'when format is invalid' do
      it do
        expect { put(:update, format: :json, params: { exchange_rate: { rate_at: nil } }) }
          .to raise_error(ActionView::MissingTemplate)
      end
    end

    context 'when exchange rate is not saved' do
      before { put :update, params: { exchange_rate: { rate_at: nil } } }

      it { expect(response).to have_http_status '422' }
      it { expect(controller).to render_template(:edit) }
    end

    context 'when all is ok' do
      before do
        put :update, params: { exchange_rate: { rate_at: exchange_rate.rate_at, rate_value: exchange_rate.rate_value } }
      end

      it { expect(response).to have_http_status :found }
      it { expect(controller).to redirect_to(admin_path) }
      it { expect(controller.notice).to eq 'Курс доллара успешно обновлён!' }
    end

    it { is_expected.to permit(:rate_at, :rate_value).for(:update, params: { exchange_rate: { param: nil } }) }
  end
end
