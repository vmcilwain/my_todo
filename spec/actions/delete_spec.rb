require 'spec_helper'

describe MyTodo do
  describe 'delete' do
    before {@todo = FactoryGirl.create(:item)}

    it 'destroys todo item' do
      expect{MyTodo::Todo.start(%W(delete #{@todo.id}))}.to change{Item.count}.by(-1)
    end

    it 'returns nil exception if todo item is invalid' do
      expect{MyTodo::Todo.start(%W[delete #{@todo.id + 1}])}.to output("undefined method `id' for nil:NilClass\n").to_stdout
    end
  end
end
