# @author Lovell McIlwain
# Handles business logic for todo tags
class Tag < ActiveRecord::Base
  # ActiveRecord asosciation to stubs
  # @note Tag.first.stubs
  has_many :stubs
  # ActiveRecord association to items
  # @note Tag.first.items
  has_many :items, through: :stubs
  # ActiveModel validation for presence of name
  validates :name, presence: true
end
