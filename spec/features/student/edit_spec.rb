require 'rails_helper'

RSpec.describe 'the student edit' do
  describe 'page' do
    before :all do
      @turing_school = School.create!(name: 'Turing', school_code: 1, is_remote: true)
      @student = @turing_school.students.create!(name: 'Richard', is_alumni: false, age: 32, degree: 'Backend')
    end

    after :all do
      School.destroy_all
    end

    it 'shows a title with the student name' do
      visit "/students/#{@student.id}/edit"

      page_title = page.find('h2')

      expect(page_title).to have_content("Edit Student #{@student.name}")
    end


    describe 'form' do
      it 'is present' do
        visit "/students/#{@student.id}/edit"
        expect(page.find('form')).to be_present
      end

      it 'has populated fields of the student' do
        visit "/students/#{@student.id}/edit"

        expect(page.find(:id, 'student_name').value).to eq('Richard')
        expect(page.find(:id, 'student_age').value).to eq('32')
        expect(page.find(:id, 'student_degree').value).to eq('Backend')
        expect(page.find(:id, 'student_is_alumni').value).to eq('false')
      end

      it 'navigates back to the edited student when form is submitted' do
        visit "/students/#{@student.id}/edit"

        within 'form' do
          find(:id, 'submit_button').click
        end
        current_path.should eq "/students/#{@student.id}"
      end
    end
  end
end
