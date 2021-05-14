class School < ApplicationRecord
  has_many :students, -> { order(name: :asc) }, dependent: :delete_all

  def remote?
    is_remote?? 'Yes' : 'No'
  end
end
