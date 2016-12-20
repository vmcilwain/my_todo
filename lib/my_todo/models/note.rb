# @author Lovell McIlwain#
# Handles business logic for todo item
class Note < ActiveRecord::Base
  # ActiveModel validation to ensure body has content
  validates :body, presence: true

  # ActiveRecord association to parent item
  # @note Note.first.item
  belongs_to :item

  # Add date to created at when record is created
  # (see #tag_created_at)
  before_save :tag_created_at, on: :create

  # Add date to updated at when record is updated
  # (see #tag_updated_at)
  before_save :tag_updated_at, on: :update

  # set created at to the current date
  def tag_created_at
    self.created_at = Date.today
  end

  # set updated at to the current date
  def tag_updated_at
    self.updated_at = Date.today if changes.size > 0
  end
end
