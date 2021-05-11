class ChangeNulls < ActiveRecord::Migration[5.2]
  def change
    change_column(:stories, :likes, :integer, default: 0, null: false)
    change_column(:stories, :name, :string, null: false)
    change_column(:stories, :published, :boolean, default: false, null: false)

    change_column(:authors, :name, :string, null: false)
    change_column(:authors, :admin, :boolean, default: false, null: false)
    change_column(:authors, :rating, :integer, default: 0, null: false)
  end
end
