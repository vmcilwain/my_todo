require 'spec_helper'

describe MyTodo do
  describe 'add_tag' do
    let(:item) {FactoryBot.create :item}
    
    context 'a successful add' do
      
      
      before {MyTodo::Todo.start(['tag', item.id, 'tag1'])}
      
      subject {item.tags.map(&:name)}
      
      it {is_expected.to eq ['tag1']}
    end

    context 'an unsuccessful add' do

      xit 'returns a validation error when tag name is missing', 'needs addressing' do
        expect{MyTodo::Todo.start(['tag', item.id])}.to output("Validation failed: Name can't be blank\n").to_stdout
      end

      it 'returns nil exception' do
        expect{MyTodo::Todo.start(['tag', item.id + 1, 'tag2'])}.to output("undefined method `id' for nil:NilClass\n").to_stdout
      end
    end
  end
end
