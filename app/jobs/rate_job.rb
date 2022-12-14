# frozen_string_literal: true

class RateJob
  @queue = :currency

  def self.perform(options = {})
    options = options.with_indifferent_access
    force = options.fetch(:force, false)

    ExchangeRates::Parser.call(ExchangeRate.first, force)
  end
end
