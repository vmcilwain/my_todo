require 'spec_helper'

describe Item, type: :model do
  it {should have_many(:stubs)}
  it {should have_many(:tags)}
  it {should validate_presence_of(:body)}
end
