# frozen_string_literal: true

require 'resque/server'

Rails.application.routes.draw do
  root 'root#index'

  get 'admin', to: 'exchange_rates#edit'

  resource :admin, controller: :exchange_rates, only: :update, as: :exchange_rate

  mount Resque::Server.new, at: '/jobs'
  mount ActionCable.server => '/cable'
end
