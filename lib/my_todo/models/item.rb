# @author Lovell McIlwain#
# Handles business logic for todo item
class Item < ActiveRecord::Base
  INCOMPLETE_STATUSES = ['None', 'In Progress', 'Waiting Feedback']
  COMPLETE_STATUSES = ['Complete', 'Punted']
  DETAILED_STATUSES = INCOMPLETE_STATUSES + COMPLETE_STATUSES
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

  before_save :update_done

  #set done attribute based on detailed_status set
  def update_done
    self.done = true if COMPLETE_STATUSES.include? self.detailed_status
  end
end
