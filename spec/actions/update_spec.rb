require 'spec_helper'

describe MyTodo do
  describe 'update' do
    before {@todo = FactoryGirl.create(:item)}
    context 'successful update' do
      before {MyTodo::Todo.start(%W(update --id=#{@todo.id} --body=hello))}
      subject {@todo.reload.body}
      it {is_expected.to eq 'hello'}
    end

    context 'unsuccessful update' do
      it 'returns validation error when body is missing' do
        expect{MyTodo::Todo.start(%W(update --id=#{@todo.id} --body=))}.to output("Validation failed: Body can't be blank\n").to_stdout
      end
    end
  end
end
