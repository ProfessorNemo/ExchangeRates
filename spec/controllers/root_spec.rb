# frozen_string_literal: true

RSpec.describe RootController do
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
