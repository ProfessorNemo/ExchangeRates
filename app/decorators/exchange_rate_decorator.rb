# frozen_string_literal: true

class ExchangeRateDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  # метод преобразование числа в валюту (100 => "100.00 руб.")
  def human_money
    @human_money ||= number_to_currency(rate_value)
  end

  def rate_at_localtime
    return if rate_at.blank?

    @rate_at_localtime ||= rate_at.localtime.strftime('%d.%m.%Y %H:%M')
  end
end
