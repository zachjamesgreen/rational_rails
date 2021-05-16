class School < ApplicationRecord
  has_many :students, dependent: :delete_all

  def remote?
    is_remote?? 'Yes' : 'No'
  end
end
