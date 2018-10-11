require 'spec_helper'

describe MyTodo do
  describe 'update' do
    let(:item) {FactoryBot.create :item}
    let(:statuses) {"0: None\n1: In Progress\n2: Waiting Feedback\n3: Complete\n4: Punted"}
    before {expect(Thor::LineEditor).to receive(:readline).with("Choose a status for item (0) ", {default: 0}).and_return("")}

    context 'successful update' do
      it 'displays the update' do
        expect{MyTodo::Todo.start(['update', item.id, 'hello'])}.to output("#{statuses}\nItem Updated\n\nid: #{item.id}     notes: 0     tags: \ncreated: #{Date.today}     status: None (done: No)     \n\nhello\n").to_stdout
      end
    end

    context 'unsuccessful update' do
      it 'returns validation error when body is missing' do
        expect{MyTodo::Todo.start(['update', item.id])}.to output("#{statuses}\nItem Updated\n\nid: #{item.id}     notes: 0     tags: \ncreated: #{Date.today}     status: None (done: No)     \n\n#{item.body}\n").to_stdout
      end
    end
  end
end
