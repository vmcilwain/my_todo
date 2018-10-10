class CreateStubs < ActiveRecord::Migration[5.2]
  def change
    create_table :stubs do |t|
      t.belongs_to :item
      t.belongs_to :tag
    end
  end
end
