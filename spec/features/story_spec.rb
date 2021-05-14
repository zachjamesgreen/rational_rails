require 'rails_helper'

RSpec.describe 'Story features' do
  before :all do
    @author1 = create(:author)
    @author2 = create(:author)
    s1 = attributes_for(:story)
    s2 = attributes_for(:story)
    s4 = attributes_for(:story)
    s1[:published] = true
    s2[:published] = false
    s4[:published] = true
    @story1 = @author1.stories.create!(s1)
    @story2 = @author1.stories.create!(s2)
    @story4 = @author1.stories.create!(s4)
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

  it 'should create a new story' do
    visit("/author/#{@author2.id}/stories")
    click_link('Create a Story for the Author')
    expect(page).to have_current_path("/author/#{@author2.id}/story/new")
    fill_in('Name', with: 'SSTTOORRYY')
    click_on('Submit')
    expect(page).to have_current_path("/author/#{@author2.id}/stories")
    expect(page).to have_content('SSTTOORRYY')
  end

  it 'should update a story' do
    visit("/story/#{@story2.id}")
    expect(page).to have_link('Update')
    click_on('Update')
    expect(page).to have_current_path("/story/#{@story2.id}/edit")
    fill_in('Name', with: 'I know this')
    click_on('Submit')
    expect(page).to have_current_path("/story/#{@story2.id}")
    expect(page).to have_content('I know this')
  end

  it 'should only show published records' do
    visit('/story')
    expect(page).to have_content(@story1.name)
    expect(page).to have_no_content(@story2.name)
  end

  it 'should have link to alphabetize stories for author' do
    author = create(:author)
    story1 = author.stories.create(name: 'C name')
    story2 = author.stories.create(name: 'B name')
    story3 = author.stories.create(name: 'A name')
    visit("/author/#{author.id}/stories")
    expect(page).to have_link('Sort By Name')
    click_link('Sort By Name')
    expect(page).to have_current_path("/author/#{author.id}/stories?sort_by_name=true")
    expect(story3.name).to appear_before(story2.name)
    expect(story2.name).to appear_before(story1.name)
  end

  it 'should have link to update story from story index page and parent story index' do
    visit('/story')
    expect(page).to have_link('Update', href: "/story/#{@story1.id}/edit")
    visit("/author/#{@author1.id}/stories")
    expect(page).to have_link('Update', href: "/story/#{@story1.id}/edit")
  end

  it 'should delete story' do
    visit("/story/#{@story3.id}")
    expect(page).to have_link('Delete', href: "/story/#{@story3.id}")
    click_on('Delete')
    expect(page).to have_current_path('/story')
    expect(page).to have_no_content(@story3.name)
  end

  it 'should delete story from index page' do
    visit('/story')
    expect(page).to have_content(@story1.name)
    expect(page).to have_link('Delete', href: "/story/#{@story1.id}")
    expect(page).to have_content(@story4.name)
    expect(page).to have_link('Delete', href: "/story/#{@story4.id}")
    click_on("delete_story_#{@story1.id}")
    expect(page).to have_current_path('/story')
    expect(page).to have_content(@story4.name)
    expect(page).to have_no_content(@story1.name)
  end

  it 'should give all authors by exact match' do

  end

  it 'should give all authors by partial match' do

  end
end