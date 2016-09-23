# @author Lovell McIlwain#
# Handles business logic for todo item
class Item < ActiveRecord::Base
  # ActiveRecord association to stubs
  # @note Item.first.stubs
  has_many :stubs
  # ActiveRecord association to tags
  # @note Item.first.tags
  # @note destroys associated stubs/tags when deleted
  has_many :tags, through: :stubs, dependent: :destroy
  # ActiveModel validation to ensure body is present
  validates :body, presence: true
end
