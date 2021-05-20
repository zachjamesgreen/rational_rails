require 'rails_helper'

RSpec.describe 'The show degrees page' do
  before :all do
    @school = School.create!(name: 'Turing', is_remote: true, school_code: 1)
    @school.students.create!(name: 'Rich', age: 33, is_alumni: true, degree: 'Computer Science')
    @school.students.create!(name: 'Dustin', age: 35, is_alumni: false, degree: 'Geology')
  end

  after :all do
    School.destroy_all
  end

  it 'has an unordered list visible' do
    visit "/schools/#{@school.id}/degrees"
    degree_list = page.find('ul.degree-list')

    within 'ul.degree-list' do
      expect(page).to have_selector('li', count: 2)
    end
  end

  it 'has a list of all pursued degrees for the selected school' do
    visit "/schools/#{@school.id}/degrees"

    within 'ul.degree-list' do
      expect(page).to have_content('Computer Science')
      expect(page).to have_content('Geology')
    end
  end
end
