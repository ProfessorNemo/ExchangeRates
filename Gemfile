# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'cssbundling-rails'
gem 'image_processing', '~> 1.2'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'rails', '~> 7.0.4'
gem 'redis', '~> 5.0'
gem 'stimulus-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'byebug'
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'fugit'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '>= 5'
  gem 'shoulda-matchers'
  gem 'sidekiq', '~> 7'
  gem 'sidekiq-cron'
  gem 'webmock', '~> 3'
end

group :development do
  gem 'bullet', '~> 7.0'
  gem 'rubocop', '~> 1.30', require: false
  gem 'rubocop-performance', '~> 1.14', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'
end

gem 'draper'
gem 'faraday'
gem 'faraday_middleware'
gem 'rails-i18n', '~> 7.0.3'
gem 'validates_timeliness', '~> 6.0.0.beta2', github: 'mitsuru/validates_timeliness', branch: 'rails7'
gem 'xml-to-json'

gem 'propshaft'
gem 'ruby-lsp', '~> 0.3.6', :group => :development
