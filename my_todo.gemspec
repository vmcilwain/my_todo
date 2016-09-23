# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'my_todo/version'

Gem::Specification.new do |spec|
  spec.name          = "my_todo"
  spec.version       = MyTodo::VERSION
  spec.authors       = ["Vell"]
  spec.email         = ["lovell.mcilwain@gmail.com"]

  spec.summary       = %q{A basic todo application with tagging.}
  spec.description   = %q{A terminal based todo application for creating todo items. Adding tags makes for an easy way to search for related items.}
  spec.homepage      = "https://github.com/vmcilwain/my_todo"
  spec.license       = "MIT"

  spec.files         = Dir["{bin,lib}/**/*", "LICENSE.txt", "README.md"]
  spec.test_files    = Dir["spec/**/*"]
  spec.bindir        = "bin"
  spec.executables   = ['my_todo']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "factory_girl_rails", "~> 4.7.0"
  spec.add_development_dependency "database_cleaner", "~> 1.5.3"
  spec.add_development_dependency 'shoulda-matchers', '~> 3.1'
  spec.add_development_dependency 'byebug', '~> 9.0.5'
  spec.add_development_dependency 'yard', '~> 0.9.5'
  spec.add_dependency 'activerecord', '~> 5.0.0.1'
  spec.add_dependency 'activesupport', '~> 5.0.0.1'
  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'standalone_migrations', '~> 5.0.0'
  spec.add_dependency 'sqlite3', '~> 1.3.11'

  spec.metadata["yard.run"] = "yri"
  spec.post_install_message = "Don't forget to migrate the db. bundle exec my_todo rake db:migrate"
end
