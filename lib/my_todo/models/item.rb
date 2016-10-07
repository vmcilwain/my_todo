# @author Lovell McIlwain#
# Handles business logic for todo item
class Item < ActiveRecord::Base
  DETAILED_STATUSES = ['None', 'In Progress', 'Complete', 'Punted', 'Waiting Feedback']
  # ActiveRecord association to stubs
  # @note Item.first.stubs
  has_many :stubs
  # ActiveRecord association to tags
  # @note Item.first.tags
  # @note destroys associated stubs/tags when deleted
  has_many :tags, through: :stubs, dependent: :destroy
  # ActiveRecord association to notes
  # @note Item.first.notes
  # @note destroys associated notes when deleted
  has_many :notes, dependent: :destroy
  # ActiveModel validation to ensure body is present
  validates :body, presence: true
end
