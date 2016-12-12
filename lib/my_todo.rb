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

module MyTodo
  # Todo tasks using thor gem
  class Todo < Thor
    # Add additional thor tasks
    include Thor::Actions

    # Private methods
    no_commands do
      def print_list
        say ERB.new(File.read("#{__dir__}/my_todo/templates/list.erb"), nil, '-').result(binding)
      end

      def print_notes
        say ERB.new(File.read("#{__dir__}/my_todo/templates/notes.erb"), nil, '-').result(binding)
      end

      def print_search_results
        say ERB.new(File.read("#{__dir__}/my_todo/templates/results.erb"), nil, '-').result(binding)
      end

      def print_item
        say ERB.new(File.read("#{__dir__}/my_todo/templates/item.erb"), nil, '-').result(binding)
      end

      def item
        @item ||= Item.where(id: options[:id]).first
      end

      def detailed_statuses
        @detailed_statuses ||= Item::DETAILED_STATUSES
      end

      def list_statuses
        detailed_statuses.each_with_index {|status, index| say "#{index}: #{status}"}
      end

      def ask_status
        list_statuses
        @status = ask("Choose a status for item", default: 1)
      end

      def item_notes
        @item_notes ||= item.notes
      end

      def all_items
        @items = case options[:status]
                when 'all'
                  Item.all
                when 'done'
                  Item.where(done: true)
                else
                  Item.where(done: false)
                end
      end

      def create_item(options)
        ask_status
        @item = Item.create!(options.merge({detailed_status: detailed_statuses[@status.to_i]}).except(:tags))
        options[:tags].split(' ').each{|tag| item.tags.create(name: tag) }
      end

      def update_item(options)
        ask_status
        new_status = detailed_statuses[@status.to_i]
        item.detailed_status != new_status ? item.update!(options.merge({detailed_status: new_status})) : item.update!(options)
      end
    end

    desc 'list([STATUS])', 'list todos. Default: undone, [all], [done], [undone]'
    option :status
    def list
      say "ToDos FOUND: #{all_items.count}"
      print_list
    end

    desc "create --body='some text' [--done=true] [--tags='tag1 tag2']", 'create a todo'
    option :body
    option :done, default: false
    option :tags, default: 'default'
    option :created_at, default: DateTime.now
    def create
      begin
        say 'ToDo CREATED!'
        create_item(options)
        print_item
      rescue ActiveRecord::RecordInvalid => e
        say e.message
      end
    end

    desc "update --id=TODO_ID --body='some text' [--done=true]", 'update an existing todo'
    option :id
    option :body
    option :done
    option :updated_at, default: DateTime.now
    def update
      begin
        update_item(options)
        say 'ToDo UPDATED!'
        print_list item
      rescue ActiveRecord::RecordInvalid => e
        say e.message
      end
    end

    desc 'delete(TODO_ID)', 'destroy a todo'
    def delete(id)
      begin
        item = Item.find_by_id(id)
        print_list item
        item.destroy!
        say 'ToDo DESTROYED!'
      rescue StandardError => e
        say e.message
      end
    end

    desc 'search', 'search for todo by item body, tag name or note body'
    option :text, required: true
    def search
      @items = Item.ransack(body_or_detailed_status_or_tags_name_or_notes_body_cont: options[:text]).result
      say "ToDos FOUND: #{@items.count}"
      say "Search based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont"
      print_search_results
    end

    desc "tag --id=TODO_ID --tag=TAG_NAME", 'add a tag to an existing todo'
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

    desc 'rm_tag --id=TODO_ID --tag=TAG_NAME', 'remove tag from an existing todo'
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

    desc "add_note --id=TODO_ID --body='text'", 'adds note to existing item'
    option :id
    option :body
    def add_note
      begin
        item.notes.create(body: options[:body])
        print_notes
      rescue StandardError => e
        say e.message
      end
    end

    desc 'rm_note --id=TODO_ID --noteid=NOTE_ID', 'remove note for exsiting item'
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

    desc 'notes(TODO_ID)', 'Display notes for a given todo'
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
