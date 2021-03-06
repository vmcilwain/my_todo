# code climent must be loaded and started before RAILS_ENV is declared
# require "codeclimate-test-reporter"
ENV['CODECLIMATE_REPO_TOKEN'] = ENV['MYTODO_CC']
# CodeClimate::TestReporter.start
ENV["RAILS_ENV"] = 'test'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'database_cleaner'
require 'factory_bot_rails'
require 'shoulda-matchers'
require 'faker'
require 'byebug'
require 'my_todo'
require 'simplecov'

SimpleCov.start


DatabaseCleaner.strategy = :truncation

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_model
    with.library :active_record
  end
end

Dir['spec/support/**/*.rb'].each { |f| require f }

FactoryBot.define do
  factory :item do
    body { Faker::Lorem.paragraph }
    detailed_status {'None'}
  end
  
  factory :note do
    item
    body {Faker::Lorem.paragraph}
  end
  
  factory :tag do
    name {Faker::Lorem.word}
  end
end

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.clean
  end
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end

# If I need to check rubocop
# rubocop   --require rubocop-rspec   --only FactoryBot/AttributeDefinedStatically   --auto-correct