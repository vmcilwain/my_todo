require 'spec_helper'

describe List, type: :model do
  it {should validate_presence_of :name}
  it {should validate_presence_of :value}
end
