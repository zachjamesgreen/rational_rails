class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :degree
      t.boolean :is_alumni, default: false
      t.integer :age
      t.belongs_to :school, foreign_key: true

      t.timestamps
    end
  end
end
