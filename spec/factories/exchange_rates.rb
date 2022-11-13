# frozen_string_literal: true

FactoryBot.define do
  factory :exchange_rate do
    currency { ExchangeRate.currencies[:usd] }
    rate_at { 2.hours.from_now }
    rate_value { 62.05 }
  end
end
