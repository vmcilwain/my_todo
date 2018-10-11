require 'spec_helper'

describe MyTodo do
  describe 'add_note' do
    let(:todo) {FactoryBot.create :item}
    let(:body) {Faker::Lorem.words(5).join("\s")}
    
    context 'successful creation' do
      it 'creates a note' do
        expect{MyTodo::Todo.start(['note', todo.id, body])}.to change{Note.count}.by(1)
      end

      it 'associates note to item', 'ehh' do
        MyTodo::Todo.start(['note', todo.id, body])
        expect(todo.notes.size).to eq 1
      end

      it 'displays item with notes' do
        expect{MyTodo::Todo.start(['note', todo.id, body])}.to output("notes for item #{todo.id}: #{todo.body}\n\nid: 1\ncreated: #{Date.today}\n\n#{body}\n\n\n").to_stdout
      end
    end

    context 'unsuccessful creation' do
      it 'returns exception if partent item is not found' do
        expect{MyTodo::Todo.start(['note', todo.id + 1])}.to output("undefined method `notes' for nil:NilClass\n").to_stdout
      end
    end
  end
end
