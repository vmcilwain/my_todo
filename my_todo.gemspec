# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'my_todo/version'

Gem::Specification.new do |spec|
  spec.name          = "my_todo"
  spec.version       = MyTodo::VERSION
  spec.authors       = ["Vell"]
  spec.email         = ["vmcilwain@me.com"]

  spec.summary       = %q{A basic todo list with tagging.}
  spec.description   = %q{A terminal based todo list that allows tagging of items}
  spec.homepage      = "https://www.github.com/vmcilwain/my_todo"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
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
end
