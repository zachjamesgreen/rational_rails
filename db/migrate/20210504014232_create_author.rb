class CreateAuthor < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.boolean :admin
      t.integer :rating, default: 0

      t.timestamps
    end
  end
end
