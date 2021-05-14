class Author < ApplicationRecord
  has_many :stories, dependent: :destroy

  validates_presence_of :name, :rating
  validates_inclusion_of :admin, in: [true, false]

  def stories_count
    stories.size
  end
end