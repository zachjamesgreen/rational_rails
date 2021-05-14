require 'rails_helper'

RSpec.describe Student, type: :model do

  describe 'relationships' do
    it { should belong_to :school }
  end

  describe 'instance methods' do
    describe '#has_graduated?' do
      it 'returns Yes if this student is an alumni' do
        student = Student.create!(name:'Dustin', age:1, is_alumni:true)
        expect(student.has_graduated?).to eq 'Yes'
      end

      it 'returns No if this student is not an alumni' do
        student = Student.create!(name:'Dustin', age:1, is_alumni:false)
        expect(student.has_graduated?).to eq 'No'
      end
    end
  end
end
