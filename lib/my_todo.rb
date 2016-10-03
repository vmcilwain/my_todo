# @author Lovell McIlwain#
# Handles running the todo application
require File.expand_path('../../lib/my_todo/version', __FILE__)
require 'thor'
require 'erb'
require 'sqlite3'
require 'active_record'
require 'active_model'
require 'yaml'
require_relative 'ar_base'
require_relative 'item'
require_relative 'stub'
require_relative 'tag'
require_relative 'note'

module MyTodo
  # Todo tasks using thor gem
  class Todo < Thor
    # Add additional thor tasks
    include Thor::Actions

    # Private methods/tasks
    no_commands do
      def output(item)
        puts ERB.new(File.read(File.expand_path("../../lib/my_todo/templates/output.erb", __FILE__))).result(binding)
      end
    end

    desc 'list([REQ])', 'list todos. Default: unfinished, [all], [finished], [unfinished]'
    def list(req=nil)
      items = case
      when req == 'all'
        Item.all
      when req == 'finished'
        Item.where(done: true)
      when req == 'unfinished'
        Item.where(done: false)
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

    desc "update --id=1 --body='some text' [--done=true]", 'update an existing todo'
    option :id
    option :body
    option :done
    option :updated_at, default: DateTime.now
    def update
      begin
        item = Item.find(options[:id])
        item.update!(options)
        say 'ToDo UPDATED!'
        output item
      rescue ActiveRecord::RecordInvalid => e
        say e.message
      end
    end

    desc 'delete(ID)', 'destroy a todo'
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
      items.each {|i| output i}
    end

    desc "tag --todo-id=1 --tag=tag1", 'add a tag to an existing todo'
    option :id
    option :tag
    def tag
      begin
        item = Item.where(id: options[:id]).first
        item.tags.create!(name: options[:tag])
      rescue Exception => e
        say e.message
      end
    end

    desc 'rm_tag --todo-id=1 --tag=tag1', 'remove tag from an existing todo'
    option :id
    option :tag
    def rm_tag
      begin
        item = Item.where(id: options[:id]).first
        item.tags.where(name: options[:tag]).first.destroy!
        output item.reload
      rescue Exception => e
        say e.message
      end
    end

    desc "note --id=1 --body='text'", 'addes note to existing item'
    option :id
    option :body
    def note
      begin
        item = Item.where(id: options[:id]).first
        item.notes.create(body: options[:body])
        output item.reload
      rescue Exception => e
        say e.message
      end
    end
  end
end

MyTodo::Todo.start(ARGV)
