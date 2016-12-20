# @author Lovell McIlwain
# Handles running the todo application
require "#{__dir__}/my_todo/version"
require 'thor'
require 'erb'
require 'sqlite3'
require 'active_record'
require 'active_model'
require 'yaml'
require 'ransack'
require_relative 'my_todo/ar_base'
require_relative 'my_todo/models/item'
require_relative 'my_todo/models/stub'
require_relative 'my_todo/models/tag'
require_relative 'my_todo/models/note'
require_relative 'my_todo/modules/templates'
require_relative 'my_todo/modules/finders'
require_relative 'my_todo/modules/my_todo_actions'
module MyTodo
  # Todo tasks using thor gem
  class Todo < Thor
    # Add additional thor tasks
    include Thor::Actions

    # Private methods
    no_commands do
      include Templates
      include Finders
      include MyTodoActions
    end

    desc 'list --status=done', 'List todos. Default: undone, [all], [done], [undone]'
    option :status, default: nil
    def list
      say "ToDos FOUND: #{all_items.count}"
      print_list
    end

    desc "create --body='some text' [--done=true] [--tags='tag1 tag2']", 'Create a todo'
    option :body
    option :done
    option :tags, default: 'default'
    def create
      begin
        say 'ToDo CREATED!'
        create_item(options)
        print_item
      rescue ActiveRecord::RecordInvalid => e
        say e.message
      end
    end

    desc "update --id=TODO_ID --body='some text' [--done=true]", 'Change an existing todo'
    option :id
    option :body
    option :done
    def update
      begin
        update_item(options)
        say 'ToDo UPDATED!'
        print_item
      rescue ActiveRecord::RecordInvalid => e
        say e.message
      end
    end

    desc 'delete', 'Destroy a todo'
    option :id, required: true
    def delete
      begin
        item.destroy!
        say 'ToDo DESTROYED!'
      rescue StandardError => e
        say e.message
      end
    end

    desc 'search', 'Find a todo by item body, tag name or note body'
    option :text, required: true
    def search
      @items = Item.ransack(body_or_detailed_status_or_tags_name_or_notes_body_cont: options[:text]).result
      say "ToDos FOUND: #{@items.count}"
      say "Search based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont"
      print_search_results
    end

    desc "tag --id=TODO_ID --tag=TAG_NAME", 'Add a tag to an existing todo'
    option :id
    option :tag
    def tag
      begin
        item.tags.create!(name: options[:tag])
        print_list item.reload
      rescue StandardError => e
        say e.message
      end
    end

    desc 'rm_tag --id=TODO_ID --tag=TAG_NAME', 'Remove tag from an existing todo'
    option :id
    option :tag
    def rm_tag
      begin
        item.tags.where(name: options[:tag]).first.destroy!
        print_list item.reload
      rescue StandardError => e
        say e.message
      end
    end

    desc "note --id=TODO_ID --body='text'", 'Adds note to existing item'
    option :id
    option :body
    def note
      begin
        item.notes.create(body: options[:body])
        print_notes
      rescue StandardError => e
        say e.message
      end
    end

    desc 'rm_note --id=TODO_ID --noteid=NOTE_ID', 'Remove note for exsiting item'
    option :id
    option :noteid
    def rm_note
      begin
        item.notes.where(id: options[:noteid]).first.destroy!
        print_list item.reload
      rescue StandardError => e
        say e.message
      end
    end

    desc 'notes --id=TODO_ID', 'Display notes for a given todo'
    option :id
    def notes
      begin
        print_notes
      rescue StandardError => e
        say e.message
      end
    end
  end
end

MyTodo::Todo.start(ARGV)
