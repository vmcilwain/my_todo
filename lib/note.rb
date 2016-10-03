# @author Lovell McIlwain#
# Handles business logic for todo item
class Note < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :item
end
