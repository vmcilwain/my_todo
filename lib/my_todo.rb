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
      def output(item)
        say ERB.new(File.read("#{__dir__}/my_todo/templates/list.erb"), nil, '-').result(binding)
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

      def all_items(status)
        case status
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
    def list(status=nil)
      items = all_items(status)
      say "ToDos FOUND: #{items.count}"
      items.each {|item| output(item)}
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
        output @item
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
        output item
      rescue ActiveRecord::RecordInvalid => e
        say e.message
      end
    end

    desc 'delete(TODO_ID)', 'destroy a todo'
    def delete(id)
      begin
        item = Item.find_by_id(id)
        output item
        item.destroy!
        say 'ToDo DESTROYED!'
      rescue StandardError => e
        say e.message
      end
    end

    desc 'search(TEXT)', 'search for todo by item body, tag name or note body'
    def search(text)
      items = Item.ransack(body_or_detailed_status_or_tags_name_or_notes_body_cont: text).result
      say "ToDos FOUND: #{items.count}"
      say "Search based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont"
      items.each {|item| output item}
    end

    desc "tag --id=TODO_ID --tag=TAG_NAME", 'add a tag to an existing todo'
    option :id
    option :tag
    def tag
      begin
        item.tags.create!(name: options[:tag])
        output item.reload
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
        output item.reload
      rescue StandardError => e
        say e.message
      end
    end

    desc "note --id=TODO_ID --body='text'", 'adds note to existing item'
    option :id
    option :body
    def note
      begin
        item.notes.create(body: options[:body])
        output item.reload
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
        output item.reload
      rescue StandardError => e
        say e.message
      end
    end
  end
end

MyTodo::Todo.start(ARGV)
