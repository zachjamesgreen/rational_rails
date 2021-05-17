require 'rails_helper'

RSpec.describe School, type: :model do

  before :all do
    @test_school = School.create!(name: 'MSU Denver', is_remote: false, school_code: 2)
    @student_1 = @test_school.students.create!(name:'Richard', degree:'Backend', age:32, is_alumni:false)
    @student_2 = @test_school.students.create!(name:'Dustin', degree:'Frontend', age:34, is_alumni:true)
  end

  after :all do
    School.destroy_all
  end

  describe 'relationships' do
    it { should have_many :students }
  end

  describe 'instance methods' do
    describe '#remote?' do
      it 'returns Yes if the school is remote' do
        school = School.create!(name: 'Turing', is_remote: true, school_code: 1)
        expect(school.remote?).to eq 'Yes'
      end

      it 'returns No if the school is not remote' do
        school = School.create!(name: 'Turing', is_remote: false, school_code: 1)
        expect(school.remote?).to eq 'No'
      end
    end

    describe '#students_by' do
      it 'returns a list of students by default' do
        students = [@student_1, @student_2]
        params = {}
        actual_students = @test_school.students_by(params)
        expect(actual_students).to eq students
      end

      it 'returns a list of sorted by name if params[:sort_by_name] is set' do
        students = [@student_2, @student_1]
        params = {sort_by_name: true}
        actual_students = @test_school.students_by(params)
        expect(actual_students).to eq students
      end

      it 'returns a list of students if age is greater than given age by user' do
        students = [@student_2]
        params = {age: 33}
        actual_students = @test_school.students_by(params)
        expect(actual_students).to eq students
      end
    end

    describe '#pursued_degrees' do
      it 'returns all the degrees of the students at the school' do
        expected_degrees = ['Backend', 'Frontend']
        expect(@test_school.pursued_degrees).to eq expected_degrees
      end
    end
  end
end
