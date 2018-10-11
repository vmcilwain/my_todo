require 'spec_helper'

describe Item, type: :model do
  let(:item) {FactoryBot.create :item}

  it {should have_many :stubs}
  it {should have_many :tags}
  it {should have_many :notes}
  it {should validate_presence_of :body}

  describe 'update_done' do
    it 'sets to true when detailed status is of a complete status' do
      item.update(detailed_status: 'Complete')
      expect(item.reload.done).to eq true
    end
    it 'sets to false when detailed status is of an incomplete status' do
      expect(item.done).to eq false
    end
  end
end
