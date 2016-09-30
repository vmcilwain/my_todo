require 'thor'

class Setup < Thor
  include Thor::Actions
  source_root File.expand_path("../lib/my_todo/templates",__dir__)
  GEM_DIR = File.expand_path("..", __dir__)

  desc 'db_config', 'Generate db configuration'
  def db_config
    template "config.yml.erb", "#{__dir__}/../lib/db/config.yml", {quiet: true, force: true}
  end

  desc 'standard_migrations_override', 'Generate SM override file'
  def standard_migrations_override
    template "standalone_migrations.yml.erb", "#{__dir__}/../.standalone_migrations", {quiet: true, force: true}
  end
end

#Setup.start(ARGV)
