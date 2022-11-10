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

  after_update_commit :dispatch_to_web, :task_job

  private

  def dispatch_to_web
    ExchangeRates::Dispatch.new(self).broadcast_rate
  end

  def task_job
    # Удаление отложенных заданий
    Resque.remove_delayed(RateJob, force: true)
    # Постановка в очередь задания (выполнять задачу через определенный
    # промежуток времени, см. resque_schedule.yml)
    Resque.enqueue_at(rate_at, RateJob, force: true)
  end
end
