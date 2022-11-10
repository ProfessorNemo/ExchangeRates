class RateJob
  @queue = :currency

  def self.perform(options = {})
    options = options.with_indifferent_access
    force = options.fetch(:force, false)

    ExchangeRates::Parser.new(ExchangeRate.first, force).call
  end
end
