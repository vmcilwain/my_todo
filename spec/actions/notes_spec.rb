require 'spec_helper'

describe MyTodo do
  describe 'notes' do
    let(:item) {FactoryBot.create(:item)}
    let(:note) {FactoryBot.create :note}
    
    context 'item has a note' do
      it 'displays note' do
        expect{MyTodo::Todo.start(['notes', note.item.id])}.to output("notes for item #{note.item.id}: #{note.item.body}\n\nid: 1\ncreated: #{Date.today}\n\n#{note.body}\n\n\n").to_stdout
      end
    end

    context "doesn't have a note" do
      it 'displays no notes message' do
        expect{MyTodo::Todo.start(['notes', item.id])}.to output("No Notes for item #{item.id}\n\n").to_stdout
      end
    end

    context 'unsuccessful creation' do
      it 'returns exception if parent item is not found' do
        expect{MyTodo::Todo.start(['note', item.id + 1])}.to output("undefined method `notes' for nil:NilClass\n").to_stdout
      end
    end
  end
end
