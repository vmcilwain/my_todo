require 'spec_helper'

describe MyTodo do
  describe 'list' do
    let(:todo1) {FactoryBot.create :item, done: true}
    let(:todo2) {FactoryBot.create :item}
    before do
      todo1;todo2
    end

    it 'displays items with done set to true' do
      expect{MyTodo::Todo.start(['list', 'done'])}.to output("Items Found: 1\n\nid: 1     notes: 0     tags: \ncreated: #{Date.today}     status: None (done: Yes)\n\n#{todo1.body}\n#{'*' * 100}\n").to_stdout
    end

    it 'displays items with done set to false by default' do
      expect{MyTodo::Todo.start(['list'])}.to output("Items Found: 1\n\nid: 2     notes: 0     tags: \ncreated: #{Date.today}     status: None (done: No)\n\n#{todo2.body}\n#{'*' * 100}\n").to_stdout
    end

    it 'displays all items' do
      expect{MyTodo::Todo.start(['list', 'all'])}.to output("Items Found: 2\n\nid: 1     notes: 0     tags: \ncreated: #{Date.today}     status: None (done: Yes)\n\n#{todo1.body}\n#{'*' * 100}\nid: 2     notes: 0     tags: \ncreated: #{Date.today}     status: None (done: No)\n\n#{todo2.body}\n#{'*' * 100}\n").to_stdout
    end
  end
end
