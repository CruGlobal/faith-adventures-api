# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  mount Sidekiq::Web => '/sidekiq'
end
