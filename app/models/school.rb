class School < ApplicationRecord
  has_many :students, -> { order(name: :asc) }

  def remote?
    is_remote?? 'Yes' : 'No'
  end
end
