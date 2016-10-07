class AddDetailedStatusToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :detailed_status, :string
  end
end
