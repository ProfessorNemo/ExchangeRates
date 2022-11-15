# frozen_string_literal: true

module ExchangeRates
  class Dispatch
    def initialize(exchange_rate)
      @exchange_rate = exchange_rate.decorate
    end

    # Шлем в канал "rate_channel" объект "@exchange_rate"
    def perform
      data = { rate_value: @exchange_rate.human_money }

      Rails.logger.info("Dollar rate: #{data}")

      ActionCable.server.broadcast('rate_channel', data)
    end
  end
end
