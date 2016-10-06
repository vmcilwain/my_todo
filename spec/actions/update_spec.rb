require 'spec_helper'

describe MyTodo do
  def shell
    @shell ||= Thor::Shell::Basic.new
  end

  describe 'update' do
    before do
      expect(Thor::LineEditor).to receive(:readline).with("Choose a status for item (1) ", {:default=>1}).and_return("In Progress")
      @todo = FactoryGirl.create(:item)
    end

    context 'successful update' do
      it 'displays the update' do
        expect{MyTodo::Todo.start(%W[update --id=#{@todo.id} --body=hello])}.to output("0: None\n1: In Progress\n2: Complete\n3: Punted\n4: Waiting Feedback\nToDo UPDATED!\n\nID: 1 | Created On: 2016-10-06 | Tags:  | Status: None | Complete: \nhello\n\n").to_stdout
      end
    end

    context 'unsuccessful update' do
      it 'returns validation error when body is missing' do
        expect{MyTodo::Todo.start(%W(update --id=#{@todo.id} --body=))}.to output("0: None\n1: In Progress\n2: Complete\n3: Punted\n4: Waiting Feedback\nValidation failed: Body can't be blank\n").to_stdout
      end
    end
  end
end
