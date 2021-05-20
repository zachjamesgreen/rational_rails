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
    visit "/schools/#{@turing_school.id}/edit"
    page_title = page.find('h2')

    expect(page_title).to have_content("Edit School #{@turing_school.name}")
    expect(page_title).to appear_before(page.find('.new-form-area'))
  end

  describe 'edit form,' do
    before :each do
      visit "/schools/#{@turing_school.id}/edit"
    end

    it 'is present' do
      expect(page.find('form')).to be_present
    end

    it 'has populated fields of the school' do
      visit "/schools/#{@turing_school.id}/edit"

      expect(page.find('#school_name').value).to eq(@turing_school.name)
      expect(page.find('#school_school_code').value).to eq(@turing_school.school_code.to_s)
      expect(page.find('#school_is_remote').value).to eq(@turing_school.is_remote.to_s)

      visit "/schools/#{@msu_school.id}/edit"

      expect(page.find('#school_name').value).to eq(@msu_school.name)
      expect(page.find('#school_school_code').value).to eq(@msu_school.school_code.to_s)
      expect(page.find('#school_is_remote').value).to eq(@msu_school.is_remote.to_s)
    end

    it 'navigates back to the edited school when form is submitted with new data visible' do
      new_name = Faker::Educator.university

      within 'form' do
        fill_in 'school[name]', with: new_name
        click_button
      end

      current_path.should eq "/schools/#{@turing_school.id}"

      expect(page.find(:id, 'school_name')).to have_content(new_name)
    end
  end
end
