require 'spec_helper'

describe MyTodo do
  describe 'search' do
    context 'success search' do
      let(:tag) {FactoryBot.create :tag}
      let(:item1) {FactoryBot.create :item, tags: [tag]}
      let(:item2) {FactoryBot.create :item}
      let(:note) {FactoryBot.create :note}

      before {item1; item2; note}

      it 'finds todo item by body' do
        expect{MyTodo::Todo.start(['search', item1.body])}.to output("Items Found: 1\n\nSearch Text: #{item1.body}\n\n\nid: #{item1.id}     notes: 0     tags: #{tag.name}\ncreated: #{Date.today}     status: None (done: No)\n\n#{item1.body}\n\n#{'*' * 100}\n").to_stdout
      end

      it 'finds todo items by associated tag' do
        expect{MyTodo::Todo.start(['search', tag.name])}.to output("Items Found: 1\n\nSearch Text: #{tag.name}\n\n\nid: #{item1.id}     notes: 0     tags: #{tag.name}\ncreated: #{Date.today}     status: None (done: No)\n\n#{item1.body}\n\n#{'*' * 100}\n").to_stdout
      end

      it 'finds todo items by detailed status' do
        item2.update!(detailed_status: 'Punted')
        expect{MyTodo::Todo.start(['search', 'Punted'])}.to output("Items Found: 1\n\nSearch Text: Punted\n\n\nid: #{item2.id}     notes: 0     tags: \ncreated: #{Date.today}     status: Punted (done: Yes)\n\n#{item2.body}\n\n#{'*' * 100}\n").to_stdout
      end

      it 'finds todo items by notes' do
        expect{MyTodo::Todo.start(['search', note.body])}.to output("Items Found: 1\n\nSearch Text: #{note.body}\n\n\nid: #{note.item.id}     notes: 1     tags: \ncreated: #{Date.today}     status: None (done: No)\n\n#{note.item.body}\n\n\s\s[#{note.id}] #{note.body}\n\s\s#{'-' * 100}\n#{'*' * 100}\n").to_stdout
      end
    end

    context 'unsuccessful search' do
      it 'returns no results when searching on invalid body' do
        expect{MyTodo::Todo.start(['search', 'abc123'])}.to output("Items Found: 0\n\nSearch Text: abc123\n\n").to_stdout
      end
    end
  end
end
