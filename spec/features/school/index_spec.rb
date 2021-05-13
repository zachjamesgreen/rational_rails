require 'rails_helper'

RSpec.describe 'the school index page' do

  before :all do
    @school_1 = School.create!(name:'Turing', is_remote: true, school_code:1)
    @school_2 = School.create!(name:'MSU Denver', is_remote:false, school_code:3)
  end

  before :each do
    visit '/schools'
  end

  it 'has a title' do
    title = page.find('h2')

    expect(title).to have_content('List of All Schools')
  end

  describe 'school list' do
    it 'has all the schools listed' do
      school_list = page.find('ul.model-list')
      school_names_seen = school_list.find_all('li').map(&:text)
      expected_school_names_seen = ["#{@school_1.name} Created at: #{@school_1.created_at}", "#{@school_2.name} Created at: #{@school_2.created_at}"]

      expect(school_names_seen).to have_selector('li', count: 2)
      expect(school_names_seen).to eq expected_school_names_seen
    end
    it 'has an edit and delete button next to each school'
  end
end
