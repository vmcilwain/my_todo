require 'spec_helper'

describe MyTodo do
  describe 'list' do
    before do
      @todo1 = FactoryGirl.create :item, done: true
      @todo1 = FactoryGirl.create :item, done: false
    end

    it 'displays items with done set to true' do
      expect{MyTodo::Todo.start(%w[list done])}.to output("ToDos FOUND: 1\n\nID: 1 | Created On: #{Date.today} | Tags:  | Status:  | Complete: true\nSome Body\n").to_stdout
    end

    it 'displays items with done set to false by default' do
      expect{MyTodo::Todo.start(%w[list])}.to output("ToDos FOUND: 1\n\nID: 2 | Created On: #{Date.today} | Tags:  | Status:  | Complete: false\nSome Body\n").to_stdout
    end

    it 'displays all items' do
      expect{MyTodo::Todo.start(%w[list all])}.to output("ToDos FOUND: 2\n\nID: 1 | Created On: #{Date.today} | Tags:  | Status:  | Complete: true\nSome Body\n\nID: 2 | Created On: #{Date.today} | Tags:  | Status:  | Complete: false\nSome Body\n").to_stdout
    end
  end
end
