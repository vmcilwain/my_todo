# @author Lovell McIlwain
#
# Handles database connection
module ArBase
  # Set path based on bin/my_todo
  path = case ENV['RAILS_ENV']
  when 'development'
    "#{__dir__}/../../db/todos_development.sqlite3"
  when 'test'
    # "#{__dir__}/../db/todos_test.sqlite3"
    "#{__dir__}/../../spec/db/todos_test.sqlite3"
  else
    File.expand_path("#{`echo $HOME`.chomp}/.my_todo/data/todos_production.sqlite3", __FILE__)
  end

  # Connect to an sqlite3 database located in lib/db
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: path,
    pool: 5,
    encoding: 'utf8'
  )
end
