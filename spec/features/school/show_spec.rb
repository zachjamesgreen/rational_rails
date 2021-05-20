require 'rails_helper'

RSpec.describe 'The show school page,' do

  before :all do
    @test_school = School.create!(name: 'Turing', school_code: 1, is_remote: true)
  end

  before :each do
    visit "/schools/#{@test_school.id}"
  end

  after :all do
    @test_school.destroy
  end

  describe 'attributes of the school,' do
    it 'has expected headers' do
      within '#header_row' do
        expect(page).to have_content('School ID')
        expect(page).to have_content('School Name')
        expect(page).to have_content('Number of Students')
        expect(page).to have_content('School Code')
        expect(page).to have_content('School Is Remote')
      end
    end

    it 'shows the attributes' do
      expect(page.find('#school_id')).to have_content(@test_school.id)
      expect(page.find('#school_name')).to have_content(@test_school.name)
      expect(page.find('#student_count')).to have_content(@test_school.students.count)
      expect(page.find('#school_code')).to have_content(@test_school.school_code)
      expect(page.find('#school_is_remote')).to have_content(@test_school.remote?)
    end
  end
  describe 'clickable buttons,' do
    describe 'Add Student,' do
      it 'navigates to /schools/:id/students/new' do
        find('#add_student_btn').click
        current_path.should eq "/schools/#{@test_school.id}/students/new"
      end
    end

    describe 'View Students,' do
      it 'navigates to /schools/:id/students' do
        find('#view_students_btn').click
        current_path.should eq "/schools/#{@test_school.id}/students"
      end
    end

    describe 'Update,' do
      it 'navigates to /schools/:id/edit' do
        find('#edit_school_btn').click
        current_path.should eq "/schools/#{@test_school.id}/edit"
      end
    end

    describe 'View degrees,' do
      it 'navigates to /schools/:id/degrees' do
        find('#view_degrees_btn').click
        current_path.should eq "/schools/#{@test_school.id}/degrees"
      end
    end

    describe 'Delete,' do
      it 'deletes school and will not be visible anymore at /schools' do
        deleted_name = @test_school.name
        find('#delete_school_btn').click
        expect(page).not_to have_content(deleted_name)
      end
    end
  end
end
