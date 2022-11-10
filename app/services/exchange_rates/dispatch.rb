module ExchangeRates
  class Dispatch
    def initialize(exchange_rate)
      @exchange_rate = exchange_rate.decorate
    end

    # Шлем в канал "rate_channel" объект "rate_value",
    # который затем получаем в коллбэке 'received' и достаем из
    # ключа "rate" наше значение
    def broadcast_rate
      ActionCable.server.broadcast('rate_channel', { rate_value: render_message })
    end

    def render_message
      ApplicationController.renderer.render(
        partial: 'root/rate',
        locals: { rate: @exchange_rate }
      )
    end
  end
end
