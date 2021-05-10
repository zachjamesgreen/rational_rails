require 'rails_helper'

RSpec.describe School, type: :model do
  describe 'instance methods' do
    describe '#remote?' do
      it 'returns Yes if the school is remote' do
        school = School.create!(name: 'Turing', is_remote: true, school_code: 1)
        expect(school.remote?).to eq 'Yes'
      end

      it 'returns No if the school is not remote' do
        school = School.create!(name: 'Turing', is_remote: true, school_code: 1)
        expect(school.remote?).to eq 'No'
      end
    end
  end
end
