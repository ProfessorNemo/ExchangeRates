# frozen_string_literal: true

class RateCronJob < ApplicationJob
  PATH = 'config/sidekiq.yml'
  SCHEDULE = YAML.load(ERB.new(Rails.root.join(PATH).read).result)
  queue_as :cron_currency
  sidekiq_options queue: SCHEDULE[:queues][1]
  sidekiq_options retry: SCHEDULE[:max_retries]

  def perform
    options = {}
    force = options.fetch(:force, true)

    ExchangeRates::Parser.call(ExchangeRate.first, force)
  end
end
