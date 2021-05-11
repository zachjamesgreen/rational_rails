class Author < ApplicationRecord
  has_many :stories, dependent: :destroy

  def stories_count
    stories.size
  end
end