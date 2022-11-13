# frozen_string_literal: true

module ExchangeRates
  class Dispatch
    def initialize(exchange_rate)
      @exchange_rate = exchange_rate.decorate
    end

    # Шлем в канал "rate_channel" объект "rate_value",
    # который затем получаем в коллбэке 'received' и достаем из
    # ключа "rate_value" наше значение
    def broadcast_rate
      data = { rate_value: @exchange_rate.human_rate_value }

      ActionCable.server.broadcast('rate_channel', data)
    end
  end
end
