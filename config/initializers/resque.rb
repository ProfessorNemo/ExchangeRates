# frozen_string_literal: true

Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))

Resque.logger.level = Logger::INFO

Resque.redis.namespace = 'resque:ExchangeRates'






















