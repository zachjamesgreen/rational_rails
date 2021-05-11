require 'rails_helper'

RSpec.describe Author do
  it 'should count how mant stories' do
    author = create(:author)
    3.times do
      s = Story.new(attributes_for(:story))
      s.author = author
      s.save!
    end
    expect(author.stories_count).to eq(3)
  end
end