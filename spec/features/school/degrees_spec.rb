require 'rails_helper'

RSpec.describe 'show degrees' do
  before :each do
    @school = School.create!(name: 'Turing', is_remote: true, school_code: 1)
    @school.students.create!(name: 'Rich', age: 33, is_alumni: true, degree: 'Computer Science')
    @school.students.create!(name: 'Dustin', age: 35, is_alumni: false, degree: 'Geology')
  end

  it 'have an unordered lists of degrees on the page' do
    visit "/schools/#{@school.id}/degrees"
    degree_list = page.find('ul.degree-list')

    expect(degree_list).to have_selector('li', count: 2)
  end

  it 'has a list of all pursued degrees' do
    visit "/schools/#{@school.id}/degrees"

    degree_list = page.find('ul.degree-list')
    degrees_seen = degree_list.find_all('li').map(&:text)

    expected_degrees = ['Computer Science', 'Geology']

    expect(degrees_seen).to eq expected_degrees
  end
end
