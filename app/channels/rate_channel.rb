# frozen_string_literal: true

class RateChannel < ApplicationCable::Channel
  extend Turbo::Streams::StreamName
  extend Turbo::Streams::Broadcasts
  include Turbo::Streams::StreamName::ClassMethods

  def subscribed
    @exchange_rate = ExchangeRate.first.decorate

    data = { rate_value: @exchange_rate.human_money }

    # регистратор ("подписан на канал")
    logger.info "Subscribed to RateChannel #{data.as_json}"

    stream_name = verified_stream_name_from_params

    stream_from stream_name
  end

  # в противном случае
  def unsubscribed
    logger.info 'Unsubscribed from RateChannel'
  end
end
