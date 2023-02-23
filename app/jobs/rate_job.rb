# frozen_string_literal: true

class RateJob < ApplicationJob
  queue_as :currency

  def perform(options = {})
    options = options.with_indifferent_access
    force = options.fetch(:force, false)

    ExchangeRates::Parser.call(ExchangeRate.first, force)
  end
end
