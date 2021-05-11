class Student < ApplicationRecord
  belongs_to :school, optional: true

  def has_graduated?
    is_alumni?? 'Yes' : 'No'
  end
end
