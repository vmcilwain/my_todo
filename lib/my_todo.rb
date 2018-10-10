# @author Lovell McIlwain
# Handles running the todo application
require 'thor'
require 'erb'
require 'sqlite3'
require 'active_record'
require 'active_model'
require 'yaml'
require 'ransack'
# require_relative "../lib/my_todo/version"
require_relative 'my_todo/ar_base'
require_relative 'my_todo/models/item'
require_relative 'my_todo/models/stub'
require_relative 'my_todo/models/tag'
require_relative 'my_todo/models/note'
require_relative 'my_todo/modules/templates'
require_relative 'my_todo/modules/finders'
require_relative 'my_todo/modules/my_todo_actions'
require_relative 'my_todo/modules/actions'

module MyTodo
  class Todo < Thor
    include Thor::Actions

    no_commands do
      include Templates
      include Finders
      include MyTodoActions
    end

    include MyTodo::Actions
  end
end

MyTodo::Todo.start(ARGV)
