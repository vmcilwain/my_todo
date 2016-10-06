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


      it 'returns todo item by body' do
        expect{MyTodo::Todo.start( %w[search nfl])}.to output("ToDos FOUND: 1\n\nID: 1 | Tags: tag1 | Complete: \nnfl\n\n").to_stdout
      end

      it 'returns todo items by associated tag' do
        expect{MyTodo::Todo.start( %w[search tag1])}.to output("ToDos FOUND: 1\n\nID: 1 | Tags: tag1 | Complete: \nnfl\n\n").to_stdout
      end

      it 'returns todo items by associated notes content' do
        expect{MyTodo::Todo.start( %w[search note1])}.to output("ToDos FOUND: 1\n\nID: 3 | Tags:  | Complete: \nalways\nNotes:\n1: note1\n\n\n").to_stdout
      end

      it 'returns only one todo item if criteria matches associated records' do
        @todo2.notes.create(body: 'who rocks')
        @todo2.tags.create(name: 'rocky')
        expect{MyTodo::Todo.start( %w[search rock])}.to output("ToDos FOUND: 1\n\nID: 2 | Tags: rocky | Complete: \nrocks\nNotes:\n2: who rocks\n\n\n").to_stdout
      end
    end

    context 'unsuccessful search' do
      it 'returns no results when searching on invalid body' do
        expect{MyTodo::Todo.start( %w(search no_body))}.to output("ToDos FOUND: 0\n").to_stdout
      end
    end
  end
end
