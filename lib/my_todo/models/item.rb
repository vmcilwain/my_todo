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

  # Add date to created at when record is created
  # (see #tag_created_at)
  before_save :tag_created_at, on: :create

  # Add date to updated at when record is updated
  # (see #tag_updatedd_at)
  before_save :tag_updated_at, on: :update

  # set create at to current date
  def tag_created_at
    self.created_at = Date.today
  end

  # set update at to current date
  def tag_updated_at
    self.updated_at = Date.today
  end
end
