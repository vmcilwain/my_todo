require 'spec_helper'

describe MyTodo do
  describe 'rm_tag' do
    let(:tag) {FactoryBot.create :tag}
    let(:tagged_item) {FactoryBot.create :item, tags: [tag]}

    context 'a successful delete' do
      before {MyTodo::Todo.start(['rm_tag', tagged_item.id, tag.name])}
      
      subject {tagged_item.reload.tags}
      
      it {is_expected.to eq []}
    end

    context 'an unsuccessful delete' do
      it 'returns nil exception if item is not found' do
        expect {MyTodo::Todo.start(['rm_tag', tagged_item.id + 1, tag.name])}.to output("undefined method `id' for nil:NilClass\n").to_stdout
      end

      it 'returns nil exception if tag is not round' do
        expect {MyTodo::Todo.start(['rm_tag', tagged_item.id, 'abc123'])}.to output("Tags removed from item #{tagged_item.id}\n\nid: #{tagged_item.id}     notes: 0     tags: #{tag.name}\ncreated: #{Date.today}     status: None (done: No)     \n\n#{tagged_item.body}\n").to_stdout
      end
    end
  end
end
