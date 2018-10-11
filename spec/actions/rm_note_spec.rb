require 'spec_helper'

describe MyTodo do
  describe 'rm_note' do
    let(:note) {FactoryBot.create :note}

    context 'a successful delete' do
      before {MyTodo::Todo.start(['rm_note', note.item.id, note.id])}
      
      subject {note.item.reload.notes}
      
      it {is_expected.to eq []}
    end

    context 'an unsuccessful delete' do
      it 'returns exception if item is not found' do
        expect {MyTodo::Todo.start(['rm_note', note.item.id + 1, note.id])}.to output("undefined method `id' for nil:NilClass\n").to_stdout
      end

      it 'returns exception if note is not found' do
        expect {MyTodo::Todo.start(['rm_note', note.item.id,  0])}.to output("Note removed from item: #{note.item.id}\n\nid: #{note.item.id}     notes: #{note.item.notes.count}     tags: \ncreated: #{Date.today}     status:  (done: No)     \n\n#{note.item.body}\n").to_stdout
      end
    end
  end
end
