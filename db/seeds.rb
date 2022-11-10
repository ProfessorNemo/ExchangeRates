# frozen_string_literal: true

unless ExchangeRate.exists?

  ExchangeRate.create!(
    currency: ExchangeRate.currencies[:usd],
    rate_at: 1.minute.from_now,
    rate_value: 0
  )
end
