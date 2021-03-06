class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name
      t.boolean :published
      t.integer :likes, default: 0, null: false
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
