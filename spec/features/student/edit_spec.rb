require 'rails_helper'

RSpec.describe 'the student edit' do
  describe 'page' do
    before :all do
      @turing_school = School.create!(name: 'Turing', school_code: 1, is_remote: true)
      @student = @turing_school.students.create!(name: 'Richard', is_alumni: false, age: 32, degree: 'Backend')
    end

    before :each do
      visit "/students/#{@student.id}/edit"
    end

    after :all do
      School.destroy_all
    end

    it 'shows a title with the student name' do
      expect(page.find('h2')).to be_present
      expect(page.find('h2')).to have_content("Edit Student #{@student.name}")
    end


    describe 'form' do
      it 'is present' do
        expect(page.find('form')).to be_present
      end

      it 'has labels for each input' do
        form = page.find('form')
        labels = form.find_all('label')

        expected_content = ['Student Name', 'Age', "Student's Degree", 'Student is Alumni']
        actual_content = labels.map(&:text)

        expect(actual_content).to eq expected_content
      end

      it 'has populated fields of the student' do
        expect(page.find(:id, 'student_name').value).to eq(@student.name)
        expect(page.find(:id, 'student_age').value).to eq(@student.age.to_s)
        expect(page.find(:id, 'student_degree').value).to eq(@student.degree)
        expect(page.find(:id, 'student_is_alumni').value).to eq(@student.is_alumni.to_s)
      end

      it 'navigates back to the edited student when form is submitted' do
        visit "/students/#{@student.id}/edit"
        new_name = Faker::Name.name

        within 'form' do
          fill_in 'student[name]', with: new_name
          find(:id, 'submit_button').click
        end

        current_path.should eq "/students/#{@student.id}"

        expect(page.find(:id, 'student_name')).to have_content(new_name)
      end
    end
  end
end
