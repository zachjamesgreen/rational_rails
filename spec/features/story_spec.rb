require 'rails_helper'

RSpec.describe 'Story features' do
  before :all do
    @author1 = create(:author)
    @author2 = create(:author)
    s1 = attributes_for(:story)
    s2 = attributes_for(:story)
    s1[:published] = true
    s2[:published] = false
    @story1 = @author1.stories.create!(s1)
    @story2 = @author1.stories.create!(s2)
    @story3 = @author1.stories.create!(attributes_for(:story))
  end

  it 'index page' do
    visit('/story')
    expect(page).to have_content('Stories')
    expect(page).to have_content(@story1.name)
    expect(page).to have_content("Likes: #{@story1.likes}")
    expect(page).to have_content("Published: #{@story1.published}")
    expect(page).to have_content("Author: #{@story1.author.name}")
  end

  it 'should show one story' do
    visit("/story/#{@story1.id}")
    expect(page).to have_content(@story1.name)
    expect(page).to have_content("Likes: #{@story1.likes}")
    expect(page).to have_content("Published: #{@story1.published}")
    expect(page).to have_content("Author: #{@story1.author.name}")
  end
end