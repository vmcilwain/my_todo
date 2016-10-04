# @author Lovell McIlwain
# Handles business logic for notes
class Note < ActiveRecord::Base
  # Require fileds for creating the record
  validates :body, presence: true
  # ActiveRecord association to items
  # @note Note.first.item
  belongs_to :item
end
