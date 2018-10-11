require 'spec_helper'

describe MyTodo do
  def shell
    @shell ||= Thor::Shell::Basic.new
  end

  describe 'create' do
    let(:body) {Faker::Lorem.words(5).join("\s")}
    let(:statuses) {"0: None\n1: In Progress\n2: Waiting Feedback\n3: Complete\n4: Punted"}
    
    before {expect(Thor::LineEditor).to receive(:readline).with("Choose a status for item (1) ", {default:1}).and_return("")}

    context 'successful creation' do
      describe 'creation without tags or setting done attribute' do
        it 'prompts for a detailed status' do
          expect(shell.ask("Choose a status for item", {:default=>1})).to eq(1)
        end

        it 'creates a todo item' do
          expect{MyTodo::Todo.start(['create', body])}.to change{Item.count}.by(1)
        end

        it "sets tags to 'default' when tags option is not present" do
          MyTodo::Todo.start(['create', body])
          todo = Item.last
          expect(todo.tags.map(&:name)).to eq ['Default']
        end

        it 'sets done to false by when done option is not present' do
          MyTodo::Todo.start(['create', body])
          todo = Item.last
          expect(todo.done).to eq false
        end

        it 'displays the created todo item' do
          expect{MyTodo::Todo.start(['create', body])}.to output("#{statuses}\nItem Created\n\nid: 1     notes: 0     tags: Default\ncreated: #{Date.today}     status: In Progress (done: No)     \n\n#{body}\n").to_stdout
        end
      end

      describe 'creation with tags and without setting done attribute' do
        it 'creates associated tag' do
          expect{MyTodo::Todo.start(['create', body, 'tag1'])}.to change{Tag.count}.by(1)
        end

        it 'displays the created todo item with tag' do
          expect{MyTodo::Todo.start(['create', body, 'tag1'])}.to output("#{statuses}\nItem Created\n\nid: 1     notes: 0     tags: tag1\ncreated: #{Date.today}     status: In Progress (done: No)     \n\n#{body}\n").to_stdout
        end
      end

      describe 'create a completed item' do
        xit 'displays the created to item with complete set to true', 'look into being able to set this option again' do
          expect{MyTodo::Todo.start(['create', body])}.to output("#{statuses}\nItem Created\n\nid: 1     notes: 0     tags: Default\ncreated: #{Date.today}     status: In Progress (done: Yes)     \n\n#{body}\n").to_stdout
        end
      end
    end

    context 'unsuccessful creation' do
      xit 'returns error message when body is missing', 'look into being able to set this option again' do
        expect{MyTodo::Todo.start(['create'])}.to output("ERROR: \"my_todo create\" was called with no arguments\n
Usage: \"my_todo create \"<BODY>\" <TAGS> [Default: general]>\"").to_stdout
      end
    end
  end
end
