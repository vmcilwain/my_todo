class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.belongs_to :item
      t.text :body
      t.timestamps null: false
    end
  end
end
