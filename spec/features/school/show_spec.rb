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
      headers = page.find(:id, 'header_row').find_all('th')

      expected_content = ['School ID', 'School Name', 'Number of Students', 'School Code', 'School Is Remote']
      seen_content = headers.map(&:text)

      expect(seen_content).to eq expected_content
    end

    it 'shows the attributes' do
      expect(page.find(:id, 'school_id')).to have_content(@test_school.id)
      expect(page.find(:id, 'school_name')).to have_content(@test_school.name)
      expect(page.find(:id, 'student_count')).to have_content(@test_school.students.count)
      expect(page.find(:id, 'school_code')).to have_content(@test_school.school_code)
      expect(page.find(:id, 'school_is_remote')).to have_content(@test_school.remote?)
    end
  end
  describe 'clickable buttons,' do
    describe 'Add Student,' do
      it 'navigates to /schools/:id/students/new' do
        find(:id, 'add_student_btn').click
        current_path.should eq "/schools/#{@test_school.id}/students/new"
      end
    end

    describe 'View Students,' do
      it 'navigates to /schools/:id/students' do
        find(:id, 'view_students_btn').click
        current_path.should eq "/schools/#{@test_school.id}/students"
      end
    end

    describe 'Update,' do
      it 'navigates to /schools/:id/edit' do
        find(:id, 'edit_school_btn').click
        current_path.should eq "/schools/#{@test_school.id}/edit"
      end
    end

    describe 'View degrees,' do
      it 'navigates to /schools/:id/degrees' do
        find(:id, 'view_degrees_btn').click
        current_path.should eq "/schools/#{@test_school.id}/degrees"
      end
    end

    describe 'Delete,' do
      it 'deletes school and will not be visible anymore at /schools' do
        find(:id, 'delete_school_btn').click

        begin
          page.find(:id, "school_data_row_#{@test_school.id}")
          fail
        rescue
          current_path.should eq '/schools'
        end
      end
    end
  end
end
