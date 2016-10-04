# @author Lovell McIlwain
# Handles running the todo application
require File.expand_path('../../lib/my_todo/version', __FILE__)
require 'thor'
require 'erb'
require 'sqlite3'
require 'active_record'
require 'active_model'
require 'yaml'
require_relative 'ar_base'
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
        say ERB.new(File.read(File.expand_path("../../lib/my_todo/templates/output.erb", __FILE__))).result(binding)
      end

      def item
        @item ||= Item.where(id: options[:id]).first
      end
    end

    desc 'list([STATUS])', 'list todos. Default: undone, [all], [done], [undone]'
    def list(status=nil)
      items = case status
      when 'all'
        Item.all
      when 'done'
        Item.where(done: true)
      else
        Item.where(done: false)
      end

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
        item = Item.create!(options.except(:tags))
        options[:tags].split(' ').each{|tag| item.tags.create(name: tag) }
        say 'ToDo CREATED!'
        output item
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
        item.update!(options)
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
      rescue Exception => e
        say e.message
      end
    end

    desc 'search(ID || BODY)', 'search for todo'
    def search(req)
      items = Item.where('id = ? or body like ?', req, "%#{req}%")
      say "ToDos FOUND: #{items.count}"
      items.each {|item| output item}
    end

    desc "tag --id=TODO_ID --tag=TAG_NAME", 'add a tag to an existing todo'
    option :id
    option :tag
    def tag
      begin
        item.tags.create!(name: options[:tag])
      rescue Exception => e
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
      rescue Exception => e
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
      rescue Exception => e
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
      rescue Exception => e
        say e.message
      end
    end
  end
end

MyTodo::Todo.start(ARGV)
