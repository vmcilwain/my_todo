require 'thor'

# Handles initial setup of application
class Setup < Thor
  include Thor::Actions
  # Look into the following location for templates
  source_root "#{__dir__}/../lib/my_todo/templates"
  # Store the root of the gem directory
  GEM_DIR = "#{__dir__}/.."

  desc 'db_config', 'Generate db configuration'
  def db_config
    template "config.yml.erb", "#{__dir__}/../lib/db/config.yml", {quiet: true, force: true}
  end

  desc 'standard_migrations_override', 'Generate SM override file'
  def standard_migrations_override
    template "standalone_migrations.yml.erb", "#{__dir__}/../.standalone_migrations", {quiet: true, force: true}
  end
end
