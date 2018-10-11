module MyTodo
  module Actions
    def self.included(thor)
      thor.class_eval do
        
        desc 'list <STATUS>', 'List todo items. Default: undone, [all], [done], [undone]'
        def list(status='undone')
          @status = status
          print_list
        end

        desc "create \"<BODY>\" <TAGS> [Default: general]>", 'Create a todo item with optional and tags'
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
        def update(id, body=nil, done=nil)
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

        desc 'delete <ID>', 'Destroy a todo item'
        # option :id, required: true
        def delete(id)
          @item = Item.find_by_id(id)
      
          begin
            item.destroy!
            say 'Item Deleted'
          rescue StandardError => e
            say e.message
          end
        end

        desc 'search "<TEXT>"', 'Find a todo by item body, tag name, status or note body'
        def search(text="")
          @text = text
          @items = Item.ransack(body_or_detailed_status_or_tags_name_or_notes_body_cont: @text).result
          print_search_results
        end

        desc 'tag <ID> <TAGS>', 'Add tags to a todo item'
        def tag(id, *tags)
          @item = Item.find_by_id(id)
      
          begin
            if tags.any?
              @banner = "Tags added to todo #{@item.id}"
              tags.each {|tag| @item.tags.create!(name: tag)}
              @item = @item.reload
              print_item
            end
          rescue StandardError => e
            say e.message
          end
        end

        desc 'rm_tag <ID>  <TAGS>', 'Remove tags from a todo item'
        def rm_tag(id, *tags)
          @item = Item.find_by_id(id)
      
          begin
            if tags.any?
              @banner = "Tags removed from item #{@item.id}"
              @item.tags.where(name: tags).destroy_all
              print_item
            end
          rescue StandardError => e
            say e.message
          end
        end

        desc 'note <ID> "<TEXT>"', 'Adds note to a todo item'
        def note(id, text="")
          @item = Item.find_by_id(id)
      
          begin
            @item.notes.create(body: text) unless text.empty?
            print_notes
          rescue StandardError => e
            say e.message
          end
        end

        desc 'rm_note <ID> <NOTE_IDS>', 'Remove notes from todo item'
        def rm_note(id, *note_ids)
          @item = Item.find_by_id(id)
      
          begin
            @banner = "Note removed from item: #{@item.id}"
            @item.notes.where(id: note_ids).destroy_all
            print_item
          rescue StandardError => e
            say e.message
          end
        end

        desc 'notes <ID>', 'Display notes for a todo item'
        def notes(id)
          @item = Item.find_by_id(id)
      
          begin
            print_notes
          rescue StandardError => e
            say e.message
          end
        end
        
      end
    end
  end
end