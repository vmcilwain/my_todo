class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :body
      t.boolean :done, default: false
      t.timestamps null: false
    end
  end
end
