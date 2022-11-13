# frozen_string_literal: true

require 'resque'
require 'resque/tasks'
require 'resque-scheduler'
require 'resque/scheduler/tasks'

namespace :resque do
  task setup: :environment do
    require 'resque'

    resque_config = YAML.load_file Rails.root.join('config/resque.yml')

    Resque.redis = resque_config['development']

    ENV['QUEUE'] = 'currency'

    Resque.schedule = YAML.load_file Rails.root.join('config/resque_schedule.yml')

    Resque::Scheduler.dynamic = true
  end
end
