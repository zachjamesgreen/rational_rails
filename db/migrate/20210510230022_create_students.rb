class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.boolean :is_alumni, default: false
      t.integer :badge_code, unique: true
      t.belongs_to :school, foreign_key: true

      t.timestamps
    end
  end
end
