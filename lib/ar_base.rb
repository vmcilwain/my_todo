# @author Lovell McIlwain
#
# Handles database connection
module ArBase
  # Set path based on bin/my_todo
  path = if ENV['RAILS_ENV'] == 'test'
    File.expand_path("../db/todos_test.sqlite3", __FILE__)
  else
    File.expand_path("#{`echo $HOME`.chomp}/.my_todo/data/todos_#{ENV['RAILS_ENV']}.sqlite3", __FILE__)
  end
  # Connect to an sqlite3 database located in lib/db
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: path,
    pool: 5,
    encoding: 'utf8'
  )
end
