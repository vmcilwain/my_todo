require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'standalone_migrations'
require_relative 'lib/my_todo'

StandaloneMigrations::Tasks.load_tasks

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
