# @author Lovell McIlwain#
# Handles business logic for todo stubs
class Stub < ActiveRecord::Base
  # ActiveRecord assocation to item
  # @note Stub.first.item
  belongs_to :item
  # ActiveRecord assocation to :tag
  # @note Stub.first.tag
  belongs_to :tag
end
