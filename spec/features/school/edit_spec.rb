require 'rails_helper'

RSpec.describe 'The school edit page' do
  before :all do
    @turing_school = School.create!(name: 'Turing', school_code: 1, is_remote: true)
    @msu_school = School.create!(name: 'MSU Denver', school_code: 2, is_remote: false)
  end

  after :all do
    School.destroy_all
  end

  it 'shows a title with the school name' do
    School.all.each do |school|
      visit "/schools/#{school.id}/edit"

      page_title = page.find('h2')
      expect(page_title).to have_content("Edit School #{school.name}")
    end
  end

  describe 'edit form,' do
    before :each do
      visit "/schools/#{@turing_school.id}/edit"
    end

    it 'is present' do
      expect(page.find('form')).to be_present
    end

    it 'has populated fields of the school' do
      School.all.each do |school|
        visit "/schools/#{school.id}/edit"

        expect(page.find(:id, 'school_name').value).to eq(school.name)
        expect(page.find(:id, 'school_code').value).to eq(school.school_code.to_s)
        expect(page.find(:id, 'school_is_remote').value).to eq(school.is_remote.to_s)
      end
    end

    it 'navigates back to the edited school when form is submitted with new data visible' do
      within 'form' do
        fill_in 'school[name]', with: Faker::Educator.university
        find(:id, 'submit_button').click
      end

      current_path.should eq "/schools/#{@turing_school.id}"
    end
  end
end
