require 'rails_helper'

RSpec.describe Student, type: :model do

  describe 'relationships' do
    it { should belong_to :school }
  end

  describe 'instance methods' do
    before :all do
      @test_school = School.create!(name:'Turing', is_remote: true, school_code: 1)
    end
    after :all do
      @test_school.destroy
    end
    describe '#has_graduated?' do
      it 'returns Yes if this student is an alumni' do
        student = @test_school.students.create!(name:'Dustin', age:1, is_alumni:true)
        expect(student.has_graduated?).to eq 'Yes'
      end

      it 'returns No if this student is not an alumni' do
        student = @test_school.students.create!(name:'Dustin', age:1, is_alumni:false)
        expect(student.has_graduated?).to eq 'No'
      end
    end
  end
end
