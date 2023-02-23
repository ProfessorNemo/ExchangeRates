# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
  CURRENCY = { empty: 0, usd: 'Доллар', eur: 'Евро' }.freeze

  enum currency: CURRENCY.keys, _prefix: true

  validates :currency, :rate_at, :rate_value, presence: true

  # имеет формат даты
  validates :rate_at,
            timeliness: { type: :datetime, after: :now },
            if: ->(record) { record.rate_at.present? }

  # имеет числовое значение не меньше "0"
  validates :rate_value,
            numericality: { greater_than_or_equal_to: 0 },
            if: ->(record) { record.rate_value.present? }

  after_update_commit :task_job, :dispatch_to_web

  private

  def dispatch_to_web
    ExchangeRates::Dispatch.call self
  end

  def task_job
    # Постановка в очередь задания (выполнять задачу через определенный
    # промежуток времени, см. schedule.yml)
    RateJob.set(wait_until: rate_at).perform_later(force: true)
  end
end
