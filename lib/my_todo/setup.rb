# @author Lovell McIlwain
#
# Handles logic for initializing and updating of application
require 'thor'

class Setup < Thor
  include Thor::Actions
  # Look into the following location for templates
  source_root "#{__dir__}/../lib/my_todo/templates"
  # Store the root of the gem directory
  GEM_DIR = "#{__dir__}/.."
  # Store users home directory
  HOME_DIR = `echo $HOME`.chomp

  desc 'db_config', 'Generate data file structure and configuration files'
  def db_config
    unless File.exists?("#{HOME_DIR}/.my_todo/data")
      `mkdir -p #{HOME_DIR}/.my_todo/data`
      say "Created .my_todo in #{HOME_DIR}"
    end
    template "config.yml.erb", "#{__dir__}/../lib/db/config.yml", force: true
  end

  desc 'standard_migrations_override', 'Generate SM override file'
  def standard_migrations_override
    template "standalone_migrations.yml.erb", "#{__dir__}/../.standalone_migrations", force: true
  end
end
