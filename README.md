## Installation

To install this gem onto your system

```ruby
gem install my_todo
```

## setup
Create and migrate the DB

`my_todo rake db:migrate`

## Usage
Simply type `my_todo` to see a list of commands

Example of creating a todo item

```ruby
my_todo create --body='hello world'
```

will display

```
ToDo CREATED!


ID: 4
ToDo: hello world
Tags: default
Complete: false
```

Example of listing pending todos

```ruby
my_todo list
```

will display

```
ToDos FOUND: 1


ID: 3
ToDo: hello world
Tags: default
Complete: false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then `RAILS_ENV=development bin/my_todo rake db:migrate` to create the development DB. You can also run `RAILS_ENV=development bin/console` for an interactive prompt that will allow you to experiment.

NOTE: In development, all commands must be run with the RAILS_ENV included. This is to make sure any changes made go to the right db. Any commands ran without the RAILS_ENV specified will default to production.

## Testing

Run `RAILS_ENV=test bin/my_todo rake db:migrate` to create the test db. Then run `rake` to run the RSpec tests.

## Releasing
To release a new version,
* update the version number in `version.rb`
* tag the the code `git tag v1.0.0`
* push the tag `git push --tags`
* then run `bundle exec rake build`
* `gem push pkg/my_todo-verion`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vmcilwain/my_todo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
