class CreateStubs < ActiveRecord::Migration[5.0]
  def change
    create_table :stubs do |t|
      t.belongs_to :item
      t.belongs_to :tag
    end
  end
end
