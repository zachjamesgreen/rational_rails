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
    expect(title).to appear_before(page.find('#students_table'))
  end

  describe 'clickable button' do
    describe 'Edit student,' do
      before :each do
        students_table = page.find('#students_table')
        @edit_button = students_table.find("#edit_student_#{@student_1.id}_btn")
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
    it 'has all the students listed by name in ascending order' do
      students_table = page.find('#students_table')

      student_row_1 = find("#student_data_row_#{@student_1.id}")
      student_row_2 = find("#student_data_row_#{@student_2.id}")

      within '#students_table' do
        expect(page).to have_content('Student Name')
        expect(page).to have_content('Creation Date')
        expect(student_row_1).to have_content(@student_1.name)
        expect(student_row_1).to have_content(@student_1.created_at.to_s)
        expect(student_row_2).to have_content(@student_2.name)
        expect(student_row_2).to have_content(@student_2.created_at.to_s)
      end

      expect(student_row_1).to appear_before(student_row_2)
    end
  end
end
