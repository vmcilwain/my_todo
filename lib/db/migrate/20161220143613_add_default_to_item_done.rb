class AddDefaultToItemDone < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :done, :boolean, default: false
  end
end
