# frozen_string_literal: true

class RateCronJob < ApplicationJob
  queue_as :cron_currency

  def perform
    options = {}
    force = options.fetch(:force, true)

    ExchangeRates::Parser.call(ExchangeRate.first, force)
  end
end
