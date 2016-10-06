require 'spec_helper'

describe MyTodo do
  def shell
    @shell ||= Thor::Shell::Basic.new
  end

  describe 'create' do
    before do
      expect(Thor::LineEditor).to receive(:readline).with("Choose a status for item (1) ", {:default=>1}).and_return("")
    end

    context 'successful creation' do
      describe 'creation without tags or setting done attribute' do
        it 'prompts for a detailed status' do
          expect(shell.ask("Choose a status for item", {:default=>1})).to eq(1)
        end

        it 'creates a todo item' do
          expect{MyTodo::Todo.start(%w(create --body=wierdness_of_text))}.to change{Item.count}.by(1)
        end

        it "sets tags to 'default' when tags option is not present" do
          MyTodo::Todo.start(%w[create --body=wierdness_of_text])
          todo = Item.last
          expect(todo.tags.map(&:name)).to eq ['default']
        end

        it 'sets done to false by when done option is not present' do
          MyTodo::Todo.start(%w[create --body=wierdness_of_text])
          todo = Item.last
          expect(todo.done).to eq false
        end

        it 'displays the created todo item' do
          expect{MyTodo::Todo.start(%w(create --body=wierdness_of_text))}.to output("0: None\n1: In Progress\n2: Complete\n3: Punted\n4: Waiting Feedback\nToDo CREATED!\n\nID: 1 | Created On: 2016-10-06 | Tags: default | Status: In Progress | Complete: false\nwierdness_of_text\n\n").to_stdout
        end
      end

      describe 'creation with tags and without setting done attribute' do
        it 'creates associated tag' do
          expect{MyTodo::Todo.start(%w[create --body=wierdness_of_text --tags=tag1])}.to change{Tag.count}.by(1)
        end

        it 'displays the created todo item with tag' do
          expect{MyTodo::Todo.start(%w(create --body=wierdness_of_text --tags=tag1))}.to output("0: None\n1: In Progress\n2: Complete\n3: Punted\n4: Waiting Feedback\nToDo CREATED!\n\nID: 1 | Created On: 2016-10-06 | Tags: tag1 | Status: In Progress | Complete: false\nwierdness_of_text\n\n").to_stdout
        end
      end

      describe 'create with tags and setting done attribute' do

        it 'creates todo item with flag set to done' do
          MyTodo::Todo.start(%w[create --body=wierdness_of_text --done=true])
          todo = Item.last
          expect(todo.done).to eq true
        end

        it 'displays the created to item with complete set to true' do
          expect{MyTodo::Todo.start(%w[create --body=wierdness_of_text --done=true])}.to output("0: None\n1: In Progress\n2: Complete\n3: Punted\n4: Waiting Feedback\nToDo CREATED!\n\nID: 1 | Created On: 2016-10-06 | Tags: default | Status: In Progress | Complete: true\nwierdness_of_text\n\n").to_stdout
        end
      end
    end

    context 'unsuccessful creation' do
      it 'returns error message when body is missing' do
        expect{MyTodo::Todo.start(%w(create))}.to output("0: None\n1: In Progress\n2: Complete\n3: Punted\n4: Waiting Feedback\nValidation failed: Body can't be blank\n").to_stdout
      end
    end
  end
end
