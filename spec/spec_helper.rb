ENV['RAILS_ENV'] ||= 'test'

require 'bundler/setup'

require_relative 'app/config/environment'
require_relative '../lib/js-text-rails'

require 'rspec/rails'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
