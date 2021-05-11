class School < ApplicationRecord
  has_many :students

  def remote?
    (is_remote)? 'Yes' : 'No'
  end
end
