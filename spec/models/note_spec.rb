require 'spec_helper'

describe Note, type: :model do
  it {should belong_to :item}
  it {should validate_presence_of :body}
end
