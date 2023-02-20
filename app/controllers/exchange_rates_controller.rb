# frozen_string_literal: true

class ExchangeRatesController < ApplicationController
  def edit; end

  def update
    if exchange_rate.update exchange_rate_params.merge(rate_at: rate_at)
      redirect_to admin_path, notice: 'Курс доллара успешно обновлён!'
    else
      render :edit
    end
  end

  private

  def exchange_rate_params
    params.require(:exchange_rate).permit(:rate_at, :rate_value)
  end

  def rate_at
    return if exchange_rate_params[:rate_at].blank?

    exchange_rate_params[:rate_at].to_time.utc
  end
end
