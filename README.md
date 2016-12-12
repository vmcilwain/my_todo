# My Todo
[![Code Climate](https://codeclimate.com/github/vmcilwain/my_todo/badges/gpa.svg)](https://codeclimate.com/github/vmcilwain/my_todo)

[![Test Coverage](https://codeclimate.com/github/vmcilwain/my_todo/badges/coverage.svg)](https://codeclimate.com/github/vmcilwain/my_todo/coverage)

[![Issue Count](https://codeclimate.com/github/vmcilwain/my_todo/badges/issue_count.svg)](https://codeclimate.com/github/vmcilwain/my_todo)

## Summary
This is yet another simple todo application. This was built because I found myself having to create quick reminders when things came up but needing to switch windows from the terminal to the todo application via the GUI. This application is the result of that one annoyance :). It is still a work in progress but I hope you find it useful.

## Features
* SQLIte3 backend (database is located in $HOME/.my_todo)
* CRUD actions for todo items (Create, Read, Update & Delete)
* Tag / Untag todo items to group / ungroup them.
* Search for todo items
* Add / Remove additional notes to todo items

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

Use aliasing to shorten the syntax:
```
#aliases
alias m='my_todo'
alias mlist='my_todo list'
alias mcreate='my_todo create'
alias mupdate='my_todo update'
alias mdelete='my_todo delete'
alias mtag='my_todo tag'
alias mrmtag='my_todo rm_tag'
alias mnote='my_todo note'
alias mrmnote='my_todo rm_note'
alias msearch='my_todo search'
```

Functions can be created around these actions to possibly shorten the syntax that much more

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then `RAILS_ENV=development bin/my_todo rake db:migrate` to create the development DB. You can also run `RAILS_ENV=development bin/console` for an interactive prompt that will allow you to experiment.

NOTE: In development, all commands must be run with the RAILS_ENV included. This is to make sure any changes made go to the right db. Any commands ran without the RAILS_ENV specified will default to production.

## Testing

Run `RAILS_ENV=test bin/my_todo rake db:migrate` to create the test db. Then run `RAILS_ENV=test bundle exec rake` to run the RSpec tests.

## Releasing
To release a new version,
* update the version number in `version.rb`
* tag the the code `git tag v1.0.0`
* push the tag `git push --tags`
* then run `bundle exec rake build`
* `gem push pkg/my_todo-verion`

## Removing the gem
To remove the gem simply type `gem uninstall my_todo`. Along with this, you will need to remove `$HOME/.my_todo` to remove the database.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vmcilwain/my_todo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
