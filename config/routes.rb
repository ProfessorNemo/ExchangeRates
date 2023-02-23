# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  resource :user, controller: :currencies, only: :index, as: :currency

  get 'admin', to: 'exchange_rates#edit'
  get 'user', to: 'currencies#index'

  resource :admin, controller: :exchange_rates, only: :update, as: :exchange_rate
end
