# @author Lovell McIlwain
#
# Handles database connection
module ArBase
  # Connect to an sqlite3 database located in lib/db
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: File.expand_path("../db/todos_#{ENV['RAILS_ENV']}.sqlite3", __FILE__),
    pool: 5,
    encoding: 'utf8'
  )
end
