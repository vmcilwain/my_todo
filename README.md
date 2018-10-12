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

* Tagging
* Search
* Notes

## Requirements

Ruby 2.2.2 and above

## Installation

```ruby
gem install my_todo
```

## Setup
Create and migrate the database. This should always be done after every version update to ensure proper paths are set at a minium.

```ruby
mytodo rake db:migrate
```
## Usage

Type `mytodo` to see the help text

### Examples

#### Creating a todo item

```ruby
mytodo create 'hello world'
```

will then ask if you want to give it an initial status

```
0: None
1: In Progress
2: Waiting Feedback
3: Complete
4: Punted

Choose a status for item (1)
```

`In Progress` is the default (just hit enter to keep going). Setting it to None will leave it blank.

Once selected and `Enter`/`Return` is pressed, something like the following should display:
 
```
Item Created

id: 1     notes: 0     tags: Default
created: 2018-10-11     status: In Progress (done: No)

hello world
```

#### List pending todo items

```ruby
mytodo list
```

will display something like

```
Items Found: 2

id: 1     notes: 0     tags: Default
created: 2018-10-11     status: In Progress (done: No)

hello world
****************************************************************************************************
id: 2     notes: 0     tags: Default
created: 2018-10-11     status: In Progress (done: No)

goodbye world
****************************************************************************************************
```

## Removing the gem and data

Uninstall the gem: `gem uninstall my_todo`

Delete `$HOME/.my_todo` to remove the data

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then `RAILS_ENV=development bin/mytodo rake db:migrate` to create the development DB (in the db directory). You can also run `RAILS_ENV=development bin/console` for an interactive prompt that will allow you to experiment.

##### Note: In development, all commands must be run with the RAILS_ENV included. This is to make sure any data written made go to the right db. Any commands ran without the RAILS_ENV specified will default to production. Example: `RAILS_ENV=development bin/mytodo list`

## Testing

Run `RAILS_ENV=test bin/mytodo rake db:migrate` to create the test db (in spec/db). Then run `bundle exec rake` to run the RSpec tests.

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
