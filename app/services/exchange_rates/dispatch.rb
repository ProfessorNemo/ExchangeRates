# frozen_string_literal: true

module ExchangeRates
  class Dispatch < ::ApplicationService
    def initialize(exchange_rate)
      @exchange_rate = exchange_rate.decorate

      super
    end

    # Шлем в канал "rate_channel" объект "@exchange_rate"
    def call
      data = { rate_value: @exchange_rate.human_money }

      Rails.logger.info("Dollar rate: #{data}")

      ActionCable.server.broadcast('rate_channel', { content: data[:rate_value] })
    end
  end
end

