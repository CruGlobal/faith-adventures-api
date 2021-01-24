# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'acts_as_list'
gem 'acts-as-taggable-on', '~> 7.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'firebase_id_token'
gem 'friendly_id', '~> 5.4.0'
gem 'graphql'
gem 'graphql-batch'
gem 'hiredis'
gem 'httparty'
gem 'jwt'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'rails', '~> 6.0.3'
gem 'redis'
gem 'rollbar'
gem 'sidekiq'
gem 'sidekiq-cron'

group :test do
  gem 'database_cleaner-active_record'
  gem 'rspec-retry'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
end
