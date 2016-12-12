require 'spec_helper'

describe MyTodo do
  describe 'notes' do
    before {@todo = FactoryGirl.create(:item)}

    context 'item has a note' do
      before {@todo.notes.create(body: 'What a world!')}

      it 'displays note' do
        expect{MyTodo::Todo.start(%W[notes --id=#{@todo.id}])}.to output("Notes for 1: Some Body\nID: 1 | Created On: 2016-12-12\nWhat a world!\n\n\n").to_stdout
      end
    end

    context "doesn't have a note" do
      it 'displays no notes message' do
        expect{MyTodo::Todo.start(%W[notes --id=#{@todo.id}])}.to output("No Notes for item #{@todo.id}\n\n").to_stdout
      end
    end

    context 'unsuccessful creation' do
      it 'returns exception if partent item is not found' do
        expect{MyTodo::Todo.start(%W[add_note --id=#{@todo.id + 1}])}.to output("undefined method `notes' for nil:NilClass\n").to_stdout
      end
    end
  end
end
