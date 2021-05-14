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
    expect(page).to have_link("See all #{@author1.stories.size} stories", href: "/author/#{@author1.id}/stories")
  end

  it 'should have link to create author' do
    visit("/authors")
    expect(page).to have_link("Create an Author", href: "/author/new")
  end

  it 'should create a new author' do
    visit("/author/new")
    fill_in('Name', with: 'zach')
    click_on('Submit')
    expect(page).to have_current_path('/authors')
    expect(page).to have_content('zach')
  end

  it 'should update an author' do
    visit("/author/#{@author1.id}")
    click_link('Update')
    fill_in('Name', with: 'zach')
    click_on('Submit')
    expect(page).to have_current_path("/author/#{@author1.id}")
    expect(page).to have_content('zach')
  end

  it 'should have link to create new story' do
    visit("/author/#{@author2.id}/stories")
    expect(page).to have_link('Create a Story for the Author')
  end

  it 'should show number of stories and sort' do
    visit('/authors')
    click_link('Sort by Stories')
    expect(page).to have_current_path('/authors?sort_by_stories=true')
    expect(page).to have_content('Stories: 3')
    expect(@author2.name).to appear_before(@author1.name, only_text: true)
  end

  it 'should have link to edit from author index page' do
    visit('/authors')
    expect(page).to have_link('Update', href: "/author/#{@author1.id}/edit")
  end

  it 'should delete author and all stories from show page' do
    story = @author2.stories.create(name: 'Delete Me')
    visit("/author/#{@author2.id}")
    expect(page).to have_content(@author2.name)
    expect(page).to have_link('Delete', href: "/author/#{@author2.id}")
    click_on('Delete')
    expect(page).to have_current_path('/authors')
    expect(page).to have_no_content(@author2.name)
    visit('/story')
    expect(page).to have_no_content(story.name)
  end

  it 'should show stories with likes greater than given number' do
    s1 = @author2.stories.create(name: 'High Likes', likes: 100)
    s2 = @author2.stories.create(name: 'Med Likes', likes: 50)
    s3 = @author2.stories.create(name: 'Low Likes', likes: 20)
    visit("/author/#{@author2.id}/stories")
    expect(page).to have_content(s1.name)
    expect(page).to have_content(s2.name)
    expect(page).to have_content(s3.name)
    fill_in('Filter by likes greater than', with: 50)
    click_on('Submit')
    expect(page).to have_current_path("/author/#{@author2.id}/stories?greater_than=50&Submit=")
    expect(page).to have_content(s1.name)
    expect(page).to have_no_content(s2.name)
    fill_in('Filter by likes greater than', with: 20)
    click_on('Submit')
    expect(page).to have_content(s2.name)
    expect(page).to have_no_content(s3.name)
  end

  it 'should delete author from index page' do
    visit('/authors')
    expect(page).to have_content(@author1.name)
    expect(page).to have_link('Delete', href: "/author/#{@author1.id}")
    expect(page).to have_content(@author2.name)
    expect(page).to have_link('Delete', href: "/author/#{@author2.id}")
    click_on("delete_author_#{@author2.id}")
    expect(page).to have_current_path('/authors')
    expect(page).to have_content(@author1.name)
    expect(page).to have_no_content(@author2.name)
  end

  it 'should give all authors by exact match' do
    visit('/authors')
    expect(page).to have_content(@author1.name)
    expect(page).to have_content(@author2.name)
    fill_in('exact_match', with: @author1.name[0..3])
    click_on('exact_match_submit')
    expect(page).to have_no_content(@author1.name)
    fill_in('exact_match', with: @author1.name)
    click_on('exact_match_submit')
    expect(page).to have_content(@author1.name)
  end

  it 'should give all authors by partial match' do
    visit('/authors')
    expect(page).to have_content(@author1.name)
    expect(page).to have_content(@author2.name)
    fill_in('partial_match', with: @author1.name[0..3])
    click_on('partial_match_submit')
    expect(page).to have_content(@author1.name)
  end
end