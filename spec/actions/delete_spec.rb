require 'spec_helper'

describe MyTodo do
  describe 'delete' do
    let(:todo) {FactoryBot.create(:item)}
    
    before {todo}
    
    it 'destroys todo item' do
      expect{MyTodo::Todo.start(['delete', todo.id])}.to change{Item.count}.by(-1)
    end

    it 'returns nil exception if todo item is invalid' do
      expect{MyTodo::Todo.start(['delete', todo.id + 1])}.to output("undefined method `destroy!' for nil:NilClass\n").to_stdout
    end
    
    it 'displays a notice' do
      expect{MyTodo::Todo.start(['delete', todo.id])}.to output("ToDo DESTROYED!\n").to_stdout
    end
  end
end
