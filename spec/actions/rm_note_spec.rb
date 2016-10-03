require 'spec_helper'

describe MyTodo do
  describe 'rm_note' do
    before do
      @todo = FactoryGirl.create :item
      @todo.notes.create(body: 'Body of text')
    end

    context 'a successful delete' do
      before {MyTodo::Todo.start(%W[rm_note --id=#{@todo.id} --noteid=#{@todo.notes.first.id}])}
      subject {@todo.reload.notes}
      it {is_expected.to eq []}
    end

    context 'an unsuccessful delete' do
      it 'returns exception if item is not found' do
        expect {MyTodo::Todo.start(%W[rm_note --id=#{@todo.id + 1} --noteid=#{@todo.notes.first.id}])}.to output("undefined method `notes' for nil:NilClass\n").to_stdout
      end

      it 'returns exception if note is not found' do
        expect {MyTodo::Todo.start(%W[rm_note --id=#{@todo.id} --noteid=#{@todo.notes.first.id + 1}])}.to output("undefined method `destroy!' for nil:NilClass\n").to_stdout
      end
    end
  end
end
