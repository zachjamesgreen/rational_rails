require 'rails_helper'

RSpec.describe 'The new student page,' do

  before :all do
    @test_school = School.create!(name:'Turing', school_code:1, is_remote: true)
  end

  before :each do
    visit "/schools/#{@test_school.id}/students/new"
  end

  after :all do
    School.destroy_all
  end

  it 'has a title' do
    title = page.find('h2')
    expect(title).to be_present
    expect(title).to have_content('Create new Student')
    expect(title).to appear_before(page.find('.new-form-area'))
  end

  describe 'form,' do
    it 'is present' do
      expect(page.find('.new-form')).to be_present
    end

    it 'has labels for each input' do
      within '.new-form' do
        expect(page).to have_content('Student Name')
        expect(page).to have_content('Age')
        expect(page).to have_content("Student's Degree")
        expect(page).to have_content('Has Student Graduated?')
      end
    end

    it 'has a submit button' do
      expect(page.find('#add_student_btn')).to be_present
    end
  end
  describe 'submit button,' do
    it 'navigates back to /schools/:id/students and the new student is visible' do
      student_name = Faker::Name.name
      student_age = rand(18..65)
      degree = Faker::Educator.degree
      is_alumni = rand(2)? 'Yes' : 'No'

      within '.new-form' do
        fill_in 'student[name]', with: student_name
        fill_in 'student[age]', with: student_age
        fill_in 'student[degree]', with: degree
        select is_alumni, from: 'student[is_alumni]'
        find(:id, 'add_student_btn').click
      end

      new_student = School.first.students.first

      current_path.should eq "/schools/#{@test_school.id}/students"
      expect(page.find("#student_data_row_#{new_student.id}")).to have_content(student_name)
      expect(page).to have_content(new_student.created_at.to_s)
    end
  end
end
