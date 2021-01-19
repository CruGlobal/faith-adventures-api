# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FaithAdventure; end

class FaithAdventure::Application < Rails::Application
  config.load_defaults 6.0
  config.api_only = true
  config.active_record.schema_format = :sql
  config.active_job.queue_adapter = :sidekiq
  config.action_mailer.deliver_later_queue_name = nil
  config.active_storage.queues.analysis = nil
  config.active_storage.queues.purge = :low
  config.active_storage.queues.mirror = nil
end
