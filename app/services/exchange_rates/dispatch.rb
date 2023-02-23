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

      Turbo::StreamsChannel.broadcast_action_to(
        'money',
        action: 'update',
        target: 'currency',
        content: ApplicationController.render(
          template: 'currencies/updated', locals: { exchange_rate: @exchange_rate },
          layout: false
        )
      )
    end
  end
end
