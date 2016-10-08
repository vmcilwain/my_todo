require 'spec_helper'

describe MyTodo do
  describe 'note' do
    before {@todo = FactoryGirl.create(:item)}
    context 'successful creation' do
      it 'creates a note' do
        expect{MyTodo::Todo.start(%W[note --id=#{@todo.id} --body=note_text])}.to change{Note.count}.by(1)
      end

      it 'associates note to item' do
        MyTodo::Todo.start(%W[note --id=#{@todo.id} --body=note_text])
        expect(@todo.notes.size).to eq 1
      end

      it 'displays item with notes' do
        expect{MyTodo::Todo.start(%W[note --id=#{@todo.id} --body=note_text])}.to output("\nID: 1 | Created On: 2016-10-08 | Tags:  | Status:  | Complete: \nSome Body\nNotes:\nID: 1 | Created On: 2016-10-08\nnote_text\n\n\n").to_stdout
      end
    end

    context 'unsuccessful creation' do
      it 'returns exception if note is not found' do
        expect{MyTodo::Todo.start(%W[note --id=#{@todo.id + 1}])}.to output("undefined method `notes' for nil:NilClass\n").to_stdout
      end
    end
  end
end
