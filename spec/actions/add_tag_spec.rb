require 'spec_helper'

describe MyTodo do
  describe 'add_tag' do
    context 'a successful add' do
      before do
        @todo = FactoryGirl.create(:item)
        MyTodo::Todo.start(%W[add_tag --id=#{@todo.id} --tag=tag1])
      end
      subject {@todo.tags}
      it {is_expected.to include(Tag.first)}
    end

    context 'an unsuccessful add' do
      before {@todo = FactoryGirl.create(:item)}

      it 'returns a validation error when tag name is missing' do
        expect{MyTodo::Todo.start(%W[add_tag --id=#{@todo.id} --tag=])}.to output("Validation failed: Name can't be blank\n").to_stdout
      end

      it 'returns nil exception' do
        expect{MyTodo::Todo.start(%W[add_tag --id=#{@todo.id + 1} --tag=tag1])}.to output("undefined method `tags' for nil:NilClass\n").to_stdout
      end
    end
  end
end
