require 'spec_helper'

describe MyTodo do
  describe 'search' do
    context 'success search' do
      before do
        @todo1 = FactoryGirl.create(:item, body: 'nfl')
        @todo1.tags.create(name: 'tag1')
        @todo2 = FactoryGirl.create(:item, body: 'rocks')
        @todo3 = FactoryGirl.create(:item, body: 'always')
        @todo3.notes.create(body: 'note1')
      end

      it 'finds todo item by body' do
        expect{MyTodo::Todo.start( %w[search --text=nfl])}.to output("ToDos FOUND: 1\nSearch based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont\n\nID: 1 | Created On: #{Date.today} | Tags: tag1 | Status:  | Complete: false | Notes: 0\nnfl\n\n****************************************************************************************************\n").to_stdout
      end

      it 'finds todo items by associated tag' do
        expect{MyTodo::Todo.start( %w[search --text=tag1])}.to output("ToDos FOUND: 1\nSearch based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont\n\nID: 1 | Created On: #{Date.today} | Tags: tag1 | Status:  | Complete: false | Notes: 0\nnfl\n\n****************************************************************************************************\n").to_stdout
      end

      it 'finds todo items by detailed status' do
        @todo2.update!(detailed_status: 'None')
        expect{MyTodo::Todo.start( %w[search --text=None])}.to output("ToDos FOUND: 1\nSearch based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont\n\nID: 2 | Created On: #{Date.today} | Tags:  | Status: None | Complete: false | Notes: 0\nrocks\n\n****************************************************************************************************\n").to_stdout
      end

      it 'finds todo items by notes' do
        expect{MyTodo::Todo.start( %w[search --text=note1])}.to output("ToDos FOUND: 1\nSearch based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont\n\nID: 3 | Created On: #{Date.today} | Tags:  | Status:  | Complete: false | Notes: 1\nalways\n\n  [1] note1\n  ----------------------------------------------------------------------------------------------------\n****************************************************************************************************\n").to_stdout
      end
    end

    context 'unsuccessful search' do
      it 'returns no results when searching on invalid body' do
        expect{MyTodo::Todo.start( %w(search --text=no_body))}.to output("ToDos FOUND: 0\nSearch based on ransack search: body_or_detailed_status_or_tags_name_or_notes_body_cont\n\n").to_stdout
      end
    end
  end
end
