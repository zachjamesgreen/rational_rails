class Story < ApplicationRecord
  belongs_to :author

  validates_presence_of :name, :likes
  validates_inclusion_of :published, in: [true, false]
end
