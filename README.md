# My ToDo
[![Code Climate](https://codeclimate.com/github/vmcilwain/my_todo/badges/gpa.svg)](https://codeclimate.com/github/vmcilwain/my_todo)

[![Test Coverage](https://codeclimate.com/github/vmcilwain/my_todo/badges/coverage.svg)](https://codeclimate.com/github/vmcilwain/my_todo/coverage)

[![Issue Count](https://codeclimate.com/github/vmcilwain/my_todo/badges/issue_count.svg)](https://codeclimate.com/github/vmcilwain/my_todo)

## Summary
A CLI todo list / task manager written in Ruby.

### Explanation

Often times while coding either at home or at work, I found myself needing to create quick reminders as things came up. While this happens to everyone, I was getting annoyed with having to switch out of the console to go into another application to add it. I didn't need a GUI to manage my lists if I did things right so that set me down the path to building this CLI application. This application will more than likely always be a work in progress but I hope you find it useful should you want to try it.

## Disclaimer

This code is provided "as is" and any express or implied warranties, including the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall I or contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) sustained by you or a third party, however caused and on any theory of liability, whether in contract, strict liability, or tort arising in any way out of the use of this code, even if advised of the possibility of such damage.

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
Create and migrate the DB - This always needs to be run after every deployment to set the proper paths at the very least.

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


ID: 1 | Created On: 2016-10-04 | Tags: default | Status: In Progress | Complete: false | Notes: 0

hello world
****************************************************************************************************
```

Example of listing pending todos

```ruby
my_todo list
```

will display

```
ToDos FOUND: 2

ID: 1 | Created On: 2016-10-04 | Tags: default | Status: In Progress  | Complete: false | Notes: 0

hello world
****************************************************************************************************

ID: 2 | Created On: 2016-10-05 | Tags: default | Status: In Progress | Complete: false | Notes: 0

hello world 2
****************************************************************************************************
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
alias mnotes='my_todo notes'
alias mrmnote='my_todo rm_note'
alias msearch='my_todo search'
alias mnote='my_todo note'
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
