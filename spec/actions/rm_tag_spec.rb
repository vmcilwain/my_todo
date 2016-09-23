require 'spec_helper'

describe MyTodo do
  describe 'rm_tag' do
    before do
      @todo = FactoryGirl.create(:item)
      @todo.tags.create(name: 'tag1')
    end
    context 'a successful delete' do
      before {MyTodo::Todo.start(%W[rm_tag --id=#{@todo.id} --tag=#{@todo.tags.first.name}])}
      subject {@todo.reload.tags}
      it {is_expected.to eq []}
    end

    context 'an unsuccessful delete' do
      it 'returns nil exception if item is not found' do
        expect {MyTodo::Todo.start(%W[rm_tag --id=#{@todo.id + 1} --tag=#{@todo.tags.first.name}])}.to output("undefined method `tags' for nil:NilClass\n").to_stdout
      end

      it 'returns nil exception if tag is not round' do
        expect {MyTodo::Todo.start(%W[rm_tag --id=#{@todo.id} --tag=tag2])}.to output("undefined method `destroy!' for nil:NilClass\n").to_stdout
      end
    end
  end
end
