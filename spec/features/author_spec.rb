require 'rails_helper'

RSpec.describe 'Author features' do
  before :all do
    @author1 = create(:author)
    @author2 = create(:author)
    @story1 = @author1.stories.create!(attributes_for(:story))
    @story2 = @author1.stories.create!(attributes_for(:story))
    @story3 = @author1.stories.create!(attributes_for(:story))
  end
  it 'index page' do
    visit('/authors')
    expect(page).to have_content('Authors')
    expect(page).to have_content(@author1.name)
    expect(page).to have_content(@author2.name)
  end

  it 'should show single author' do
    visit("/author/#{@author1.id}")
    expect(page).to have_content(@author1.name)
    expect(page).to have_content("Admin: #{@author1.admin}")
    expect(page).to have_content("Rating: #{@author1.rating}")
    expect(page).to have_content("Created At: #{@author1.created_at}")
    expect(page).to have_content("Updated At: #{@author1.updated_at}")
  end

  it 'should show all stories for author' do
    visit("/author/#{@author1.id}/stories")
    expect(page).to have_content(@author1.name)
    expect(page).to have_content(@story1.name)
    expect(page).to have_content(@story2.name)
    expect(page).to have_content(@story3.name)
  end

  it 'should be in order created at asc and show created at' do
    visit('/authors')
    expect(@author1.name).to appear_before(@author2.name)
    expect(page).to have_content("Created At: #{@author1.created_at}")
    expect(page).to have_content("Created At: #{@author2.created_at}")
  end

  it 'should show count of stories for authors' do
    visit("/author/#{@author1.id}")
    expect(page).to have_content("See all #{@author1.stories.size} stories")
    visit("/author/#{@author2.id}")
    expect(page).to have_content("See all #{@author2.stories.size} stories")
  end

  it 'should have link to author index page and story index page' do
    visit('/authors')
    expect(page).to have_link('Authors Index')
    expect(page).to have_link('Stories Index')
  end

  it 'should have link on author show page to show all author stories' do
    visit("/author/#{@author1.id}")
    expect(page).to have_link("See all #{@author1.stories.size} stories")
  end

  it 'should show number of stories' do
    visit('/authors')
    click_link('Sort by Stories')
    expect(page).to have_current_path('/authors?sort_by_stories=true')
    expect(page).to have_content('Stories: 3')
    expect(@author2.name).to appear_before(@author1.name, only_text: true)
  end
end