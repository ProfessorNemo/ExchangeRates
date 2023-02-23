# frozen_string_literal: true

class CurrenciesController < ApplicationController
  def index
    @exchange_rate = exchange_rate

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@exchange_rate, template: 'currencies/updated')
      end

      format.html { @exchange_rate }
    end
  end
end
