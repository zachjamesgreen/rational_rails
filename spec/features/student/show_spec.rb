require 'rails_helper'

RSpec.describe 'The show student page,' do

  before :all do
    school = School.create!(name: 'Turing', school_code: 1, is_remote: true)
    @test_student = school.students.create!(name:'Richard', age: 32, degree: 'Backend', is_alumni: false)
  end

  before :each do
    visit "/students/#{@test_student.id}"
  end

  after :all do
    School.destroy_all
  end

  describe 'attributes of the student,' do
    it 'has expected headers' do
      headers = page.find(:id, 'header_row').find_all('th')

      expected_content = ['Student ID', 'Student Name', 'Age', 'Attending School', 'Degree', 'Graduate']
      seen_content = headers.map(&:text)

      expect(seen_content).to eq expected_content
    end

    it 'shows the attributes' do
      expect(page.find(:id, 'student_id')).to have_content(@test_student.id)
      expect(page.find(:id, 'student_name')).to have_content(@test_student.name)
      expect(page.find(:id, 'student_age')).to have_content(@test_student.age)
      expect(page.find(:id, 'student_school')).to have_content(@test_student.school.name)
      expect(page.find(:id, 'student_degree')).to have_content(@test_student.degree)
      expect(page.find(:id, 'student_graduated')).to have_content(@test_student.has_graduated?)
    end
  end
  describe 'clickable buttons,' do
    describe 'Update,' do
      it 'navigates to /students/:id/edit' do
        find(:id, 'edit_student_btn').click
        current_path.should eq "/students/#{@test_student.id}/edit"
      end
    end

    describe 'Delete,' do
      it 'deletes student and will not be visible anymore at /students' do
        find(:id, 'delete_student_btn').click

        begin
          fail if page.find(:id, "student_data_row_#{@test_student.id}")
        rescue
          current_path.should eq '/students'
        end
      end
    end
  end
end
