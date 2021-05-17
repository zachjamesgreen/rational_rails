require 'rails_helper'

RSpec.describe 'The list of students for school,' do
  before :all do
    @test_school = School.create!(name: 'Turing', is_remote: true, school_code: 1)

    FactoryBot.define do
      factory :student do
        name { Faker::FunnyName.three_word_name }
        is_alumni { rand(2) == 0 }
        degree { Faker::Educator.degree }
        age { rand(18..65) }
      end
    end

    5.times do
      attrs = FactoryBot::attributes_for(:student)
      @test_school.students.create!(attrs)
    end
  end

  before :each do
    visit "/schools/#{@test_school.id}/students"
  end

  after :all do
    School.destroy_all
  end

  it 'has a title' do
    expect(page.find('h2')).to be_present
    expect(page.find('h2')).to have_content("List of Students for #{@test_school.name}")
  end

  describe 'get students greater than given age form,' do
    it 'can be seen at the top of the list of students' do
      expect(page.find(:id, 'greater_than_age_form')).to be_present
    end

    describe 'submission button,' do
      it 'has a label' do
        form = page.find(:id, 'greater_than_age_form')

        expect(form.find('label')).to be_present
        expect(form.find('label')).to have_content('Get students older than')
      end

      it 'submits request and shows new list of students based on given query value' do
        submit_button = page.find(:id, 'submit_age_sort_btn')
        form = page.find(:id, 'greater_than_age_form')
        greater_than_age = Student.maximum(:age) - 5

        within form do
          fill_in 'age', with: greater_than_age
          find(:id, 'submit_age_sort_btn').click
        end

        expected_student_count = Student.where(school_id: @test_school.id).where("age > #{greater_than_age}").count
        student_table = page.find(:id, 'student-table')
        actual_student_count = (student_table.find_all('tr').length - 1) / 2

        expect(actual_student_count).to eq expected_student_count
      end
    end
  end

  describe 'clickable button,' do
    describe 'student name,' do
      it 'has the name of the student' do
        Student.all.each do |student|
          expect(page.find(:id, "view_student_#{student.id}")).to be_present
          expect(page.find(:id, "view_student_#{student.id}")).to have_content(student.name)
        end
      end

      it 'redirects to /students/:id' do
        student = @test_school.students.first
        view_student_button = page.find(:id, "view_student_#{student.id}")

        view_student_button.click

        current_path.should eq "/students/#{student.id}"
      end
    end

    describe 'Edit student,' do
      it 'can be seen next to each student' do
        student = @test_school.students.first
        expect(page.find(:id, "edit_student_#{student.id}")).to be_present
        expect(page.find(:id, "edit_student_#{student.id}")).to have_content('Edit')
      end

      it 'redirects to /students/:id/edit' do
        student = @test_school.students.first
        view_student_button = page.find(:id, "edit_student_#{student.id}")

        view_student_button.click

        current_path.should eq "/students/#{student.id}/edit"
      end
    end

    describe 'Delete student,' do
      it 'can be seen next to each student' do
        student = @test_school.students.first

        expect(page.find(:id, "delete_student_#{student.id}")).to be_present
        expect(page.find(:id, "delete_student_#{student.id}").value).to eq('Delete')
      end

      it 'deletes student and redirects to /schools/:id/students' do
        student = @test_school.students.first
        view_student_button = page.find(:id, "delete_student_#{student.id}")

        view_student_button.click

        current_path.should eq "/schools/#{@test_school.id}/students"
      end

      it 'the deleted student no longer is shown in list' do
        student = @test_school.students.first
        view_student_button = page.find(:id, "view_student_#{student.id}")
        delete_student_button = page.find(:id, "delete_student_#{student.id}")

        expect(view_student_button).to have_content(student.name)

        delete_student_button.click

        student = @test_school.students.first
        view_student_button = page.find(:id, "view_student_#{student.id}")

        expect(view_student_button).to have_content(student.name)
      end
    end
  end

  describe 'student list,' do
    it 'shows all students for the school' do
      expected_data_seen = Student.all.map do |student|
        [student.name, student.created_at.to_s]
      end

      student_data_rows = page.find(:id, 'student-table').find_all('tr')

      actual_data_seen = student_data_rows.filter_map do |row|
        table_data = row.find_all('td')
        table_data.map(&:text) if table_data.length > 1
      end

      expected_headers_seen = ['Student Name', 'Creation Date']

      actual_headers_seen = student_data_rows.first.find_all('th').map(&:text)

      expect(actual_data_seen).to eq expected_data_seen
      expect(actual_headers_seen).to eq expected_headers_seen
    end
  end
end
