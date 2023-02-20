# frozen_string_literal: true

class RateJob < ApplicationJob
  PATH = 'config/sidekiq.yml'
  SCHEDULE = YAML.load(ERB.new(Rails.root.join(PATH).read).result)
  queue_as :currency
  sidekiq_options queue: SCHEDULE[:queues][0]
  sidekiq_options retry: SCHEDULE[:max_retries]

  def self.perform(options = {})
    options = options.with_indifferent_access
    force = options.fetch(:force, false)

    ExchangeRates::Parser.call(ExchangeRate.first, force)
  end
end
