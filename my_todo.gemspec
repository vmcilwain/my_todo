# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'my_todo/version'

Gem::Specification.new do |spec|
  spec.name          = "my_todo"
  spec.version       = MyTodo::VERSION
  spec.authors       = ["Vell"]
  spec.email         = ["lovell.mcilwain@gmail.com"]

  spec.summary       = %q{A basic todo application with tags.}
  spec.description   = %q{A terminal based todo application for creating todo items. Adding tags makes for an easy way to group and search for related items. Create additional notes for a todo item as new related information comes up}
  spec.homepage      = "https://github.com/vmcilwain/my_todo"
  spec.license       = "MIT"

  spec.files         = Dir["{bin,lib,db}/**/*", "LICENSE.txt", "README.md", 'Rakefile', 'Gemfile', 'my_todo.gemspec']
  spec.test_files    = Dir["spec/**/*"]
  spec.bindir        = "bin"
  spec.executables   = ['my_todo']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.8.0"
  spec.add_development_dependency "factory_bot_rails", "~> 4.11.1"
  spec.add_development_dependency "database_cleaner", "~> 1.7.0"
  spec.add_development_dependency 'shoulda-matchers', '~> 3.1.2'
  spec.add_development_dependency 'byebug', '~> 10.0.2'
  spec.add_development_dependency 'yard', '~> 0.9.5'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_dependency "bundler", "~> 1.16.0"
  spec.add_dependency "rake", "~> 12.3.1"
  spec.add_dependency 'activerecord', '~> 5.2.1'
  spec.add_dependency 'activesupport', '~> 5.2.1'
  spec.add_dependency 'thor', '~> 0.20.0'
  spec.add_dependency 'standalone_migrations', '~> 5.2.6'
  spec.add_dependency 'sqlite3', '~> 1.3.13'
  spec.add_dependency 'ransack', '~> 2.0.1'

  spec.metadata["yard.run"] = "yri"
  spec.post_install_message = "Don't forget to migrate the db. `my_todo rake db:migrate`"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
end
