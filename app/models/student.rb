class Student < ApplicationRecord
  belongs_to :school

  def has_graduated?
    is_alumni?? 'Yes' : 'No'
  end
end
