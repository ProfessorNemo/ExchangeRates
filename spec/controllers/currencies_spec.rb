# frozen_string_literal: true

RSpec.describe CurrenciesController do
  let!(:exchange_rate) { create(:exchange_rate).decorate }

  describe '#index' do
    context 'when format is invalid' do
      it { expect { get(:index, format: :json) }.to raise_error(ActionController::UnknownFormat) }
    end

    context 'when all is ok' do
      before { get :index }

      it { expect(response).to have_http_status :ok }
    end
  end
end
