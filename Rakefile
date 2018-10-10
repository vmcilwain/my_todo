require "bundler/gem_tasks"

require 'standalone_migrations'

StandaloneMigrations::Tasks.load_tasks

unless ENV['RAILS_ENV'] == 'production'
  
  require "rspec/core/rake_task"
  
  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec

end
