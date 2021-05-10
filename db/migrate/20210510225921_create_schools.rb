class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.boolean :is_remote, default: false
      t.integer :school_code, unique: true

      t.timestamps
    end
  end
end
