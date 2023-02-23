RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

drop!:
	rails db:drop

initially:
	rails db:create
	rails db:migrate
	rails db:seed
	yarn install
	yarn build:css
	yarn build
	rails assets:precompile

rubocop:
	rubocop -A

rspec:
	bundle exec rspec spec/controllers/exchange_rates_spec.rb
	bundle exec rspec spec/controllers/currencies_spec.rb
	bundle exec rspec spec/decorators/exchange_rate_decorator_spec.rb
	bundle exec rspec spec/models/exchange_rate_spec.rb
	bundle exec rspec spec/jobs/rate_job_spec.rb
	bundle exec rspec spec/services/exchange_rates/parser_spec.rb
	bundle exec rspec spec/services/exchange_rates/dispatch_spec.rb
	bundle exec rspec spec/features/user_page_admin_page.rb

run-console:
	bundle exec rails console

c: run-console

