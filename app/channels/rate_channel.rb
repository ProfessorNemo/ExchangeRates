class RateChannel < ApplicationCable::Channel
  # вызывается, когда клиент по этому каналу подсоединился к серверу
  def subscribed
    # передать в JS соответствующий канал
    stream_from 'rate_channel'
  end
end
