require 'spec_helper'

describe MyTodo do
  describe 'search' do
    context 'success search' do
      before do
        @todo1 = FactoryGirl.create(:item, body: 'nfl')
        @todo2 = FactoryGirl.create(:item, body: 'rocks')
        @todo3 = FactoryGirl.create(:item, body: 'always')
      end

      it 'finds todo item by id' do
        expect{MyTodo::Todo.start( %W(search #{@todo3.id} ))}.to output("ToDos FOUND: 1\n\nID: 3\nToDo: always\nTags: \nComplete: \n").to_stdout
      end

      it 'finds todo item by body' do
        expect{MyTodo::Todo.start( %w[search nfl])}.to output("ToDos FOUND: 1\n\nID: 1\nToDo: nfl\nTags: \nComplete: \n").to_stdout
      end
    end

    context 'unsuccessful search' do
      it 'returns no results when searching by invalid id' do
        expect{MyTodo::Todo.start( %w(search 1))}.to output("ToDos FOUND: 0\n").to_stdout
      end

      it 'returns no results when searching on invalid body' do
        expect{MyTodo::Todo.start( %w(search no_body))}.to output("ToDos FOUND: 0\n").to_stdout
      end
    end
  end
end
