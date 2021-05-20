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
      within '#header_row' do
        expect(page).to have_content('Student ID')
        expect(page).to have_content('Student Name')
        expect(page).to have_content('Age')
        expect(page).to have_content('Attending School')
        expect(page).to have_content('Degree')
        expect(page).to have_content('Graduate')
      end
    end

    it 'shows the attributes' do
      expect(page.find('#student_id')).to have_content(@test_student.id)
      expect(page.find('#student_name')).to have_content(@test_student.name)
      expect(page.find('#student_age')).to have_content(@test_student.age)
      expect(page.find('#student_school')).to have_content(@test_student.school.name)
      expect(page.find('#student_degree')).to have_content(@test_student.degree)
      expect(page.find('#student_graduated')).to have_content(@test_student.has_graduated?)
    end
  end
  describe 'clickable buttons,' do
    describe 'Attending School,' do
      it 'navigates to the show school page' do
        find('#show_school').click
        current_path.should eq "/schools/#{@test_student.school_id}"
      end
    end

    describe 'Update,' do
      it 'navigates to /students/:id/edit' do
        find('#edit_student_btn').click
        current_path.should eq "/students/#{@test_student.id}/edit"
      end
    end

    describe 'Delete,' do
      it 'deletes student and will not be visible anymore at /students' do
        deleted_name = @test_student.name
        find('#delete_student_btn').click
        expect(page).not_to have_content(deleted_name)
      end
    end
  end
end
