require 'spec_helper'

describe Tag, type: :model do
  it {should validate_presence_of(:name)}
  it {should have_many(:stubs)}
  it {should have_many(:items)}
end
