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
    expect(page.find('h2')).to be_present
    expect(page.find('h2')).to have_content('Create new Student')
  end

  describe 'form,' do
    it 'is present' do
      expect(page.find('form')).to be_present
    end

    it 'has labels for each input' do
      form = page.find('form')
      labels = form.find_all('label')

      expected_content = ['Student Name', 'Age', "Student's Degree", 'Has Student Graduated?']
      actual_content = labels.map(&:text)

      expect(actual_content).to eq expected_content
    end

    it 'has a submit button' do
      form = page.find('form')
      expect(form.find(:id, 'add_student_btn')).to be_present
    end
  end
  describe 'submit button,' do
    it 'navigates back to /schools/:id/students and the new student is visible' do
      student_name = Faker::Name.name
      student_age = rand(18..65)
      degree = Faker::Educator.degree
      is_alumni = rand(2)? 'Yes' : 'No'

      within 'form' do
        fill_in 'student[name]', with: student_name
        fill_in 'student[age]', with: student_age
        fill_in 'student[degree]', with: degree
        select is_alumni, from: 'student[is_alumni]'
        find(:id, 'add_student_btn').click
      end

      new_student = School.all.first

      current_path.should eq "/schools/#{@test_school.id}/students"
      expect(page.find(:id, "student_data_row_#{new_student.id}")).to have_content(student_name)
      expect(page.find(:id, "student_data_row_#{new_student.id}")).to have_content(new_student.created_at.to_s)
    end
  end
end
