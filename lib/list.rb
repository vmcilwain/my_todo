class List < ActiveRecord::Base
  validates :name, :value, presence: true
end
