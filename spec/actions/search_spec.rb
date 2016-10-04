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
        expect{MyTodo::Todo.start( %w[search nfl])}.to output("ToDos FOUND: 1\n\nID: 1\nToDo: nfl\nTags: tag1\nComplete: \n\n").to_stdout
      end

      it 'finds todo items by associated tag' do
        expect{MyTodo::Todo.start( %w[search tag1])}.to output("ToDos FOUND: 1\n\nID: 1\nToDo: nfl\nTags: tag1\nComplete: \n\n").to_stdout
      end

      it 'finds todo items by associated notes content' do
        expect{MyTodo::Todo.start( %w[search note1])}.to output("ToDos FOUND: 1\n\nID: 3\nToDo: always\nTags: \nComplete: \n\nNotes:\n\n1: note1\n\n\n").to_stdout
      end
    end

    context 'unsuccessful search' do
      it 'returns no results when searching on invalid body' do
        expect{MyTodo::Todo.start( %w(search no_body))}.to output("ToDos FOUND: 0\n").to_stdout
      end
    end
  end
end
