# frozen_string_literal: true

class RateChannel < ApplicationCable::Channel
  # вызывается, когда клиент по этому каналу подсоединился к серверу
  def subscribed
    @exchange_rate = ExchangeRate.first.decorate

    data = { rate_value: @exchange_rate.human_money }

    # регистратор ("подписан на канал RateChannel")
    logger.info "Subscribed to RateChannel #{data.as_json}"

    # передать в JS
    stream_from 'rate_channel'
  end

  # в противном случае
  def unsubscribed
    logger.info 'Unsubscribed from RateChannel'
  end
end
