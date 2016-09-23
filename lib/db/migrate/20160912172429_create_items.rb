class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :body
      t.boolean :done
      t.timestamps null: false
    end
  end
end
