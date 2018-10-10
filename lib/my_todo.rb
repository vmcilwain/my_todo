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

module MyTodo
  class Todo < Thor
    include Thor::Actions

    no_commands do
      include Templates
      include Finders
      include MyTodoActions
    end

    desc 'list <STATUS>', 'List todos. Default: undone, [all], [done], [undone]'
    def list(status='undone')
      @status = status
      print_list
    end

    desc 'create "<BODY>" <TAGS [Default: general]>', 'Create a todo with optional and tags'
    def create(body, *tags)
      @body = body
      @tags = tags.any? ? tags : %w[Default]
      begin
        create_item
        print_item
      rescue ActiveRecord::RecordInvalid => e
        say e.message
      end
    end
    
    desc 'update <ID> "<BODY>" <DONE>', 'Update a todo item'
    def update(id, body, done)
      @item = Item.find_by_id(id)
      @body = body.nil? ? @item.body : body
      @done = done.nil? ? @item.done : done
      begin
        update_item
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
