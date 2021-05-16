require 'rails_helper'

RSpec.describe 'The student index page,' do
  before :all do
    @school = School.create!(name:'Turing', is_remote: true, school_code:1)
    @student_2 = @school.students.create!(name:'Richard', degree:'Backend', is_alumni: true, age: 32)
    @student_1 = @school.students.create!(name:'Dustin', degree:'Frontend', is_alumni: true, age: 34)
    @school.students.create!(name:'Mark', degree:'Backend', is_alumni: false, age: 29)
  end

  before :each do
    visit '/students'
  end

  after :all do
    School.destroy_all
  end

  it 'has a title' do
    title = page.find('h2')

    expect(title).to have_content('List of All Graduated Students')
  end

  describe 'clickable button' do
    describe 'Edit student,' do
      before :each do
        students_table = page.find(:id, 'students_table')
        @edit_button = students_table.find(:id, "edit_student_#{@student_1.id}_btn")
      end

      it 'should be seen next to each student' do
        expect(@edit_button).to have_content('Edit')
      end

      it 'redirects the user to /students/:id/edit' do
        @edit_button.click
        current_path.should eq "/students/#{@student_1.id}/edit"
      end
    end
  end

  describe 'students list,' do
    it 'has all the students listed' do
      students_table = page.find(:id, 'students_table')
      table_rows = students_table.find_all('tr')

      expected_data_seen = [
        [@student_1.name, @student_1.created_at.to_s],
        [@student_2.name, @student_2.created_at.to_s]]

      actual_data_seen = table_rows.filter_map do |row|
        table_data = row.find_all('td')
        table_data.map(&:text) if table_data.length > 1
      end

      expected_headers_seen = ['Student Name', 'Creation Date']

      actual_headers_seen = table_rows.first.find_all('th').map(&:text)

      expect(actual_data_seen).to eq expected_data_seen
      expect(actual_headers_seen).to eq expected_headers_seen
    end
  end
end
