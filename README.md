# MyTodo

## Installation

To install this gem onto your system

```ruby
gem install my_todo
```

## setup
Create and migrate the DB

`bundle exec my_todo rake db:migrate`

## Usage
Simply type `my_todo` to see a list of commands

Example of creating a todo item

```ruby
my_todo create --body='hello world'
```

Example of listing pending todos

```ruby
my_todo list
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then `RAILS_ENV=development bundle exec my_todo rake db:migrate` to create the development DB. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

NOTE: In development, all commands must be run with the rails environment included. This is to make sure any changes made go to the right db.

## Testing

Run `RAILS_ENV=test bin/todo rake db:migrate` to create the test db. Then run `rake` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vmcilwain/my_todo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
