require 'rails_helper'

RSpec.describe 'The new school page,' do

  before :each do
    visit '/schools/new'
  end

  after :all do
    School.destroy_all
  end

  it 'has a title' do
    title = page.find('h2')
    expect(title).to be_present
    expect(title).to have_content('Create a new School')
    expect(title).to appear_before(page.find('.new-form-area'))
  end

  describe 'form,' do
    it 'is present' do
      expect(page.find('.new-form')).to be_present
    end

    it 'has labels for each input' do
      within '.new-form' do
        expect(page).to have_content('Name of School')
        expect(page).to have_content('School Code')
        expect(page).to have_content('Is the School Remote?')
      end
    end

    it 'has a submit button' do
      form = page.find('.new-form')
      expect(form.find('#add_school_btn')).to be_present
    end
  end
  describe 'submit button,' do
    it 'navigates back to /schools and the new school is visable' do
      school_name = Faker::Educator.university
      school_code = rand(99999)
      is_remote = rand(2)? 'Yes' : 'No'

      within 'form' do
        fill_in 'school[name]', with: school_name
        fill_in 'school[school_code]', with: school_code
        select is_remote, from: 'school[is_remote]'
        find(:id, 'add_school_btn').click
      end

      new_school = School.all.first

      current_path.should eq '/schools'
      expect(page.find("#school_data_row_#{new_school.id}")).to have_content(school_name)
      expect(page.find("#school_data_row_#{new_school.id}")).to have_content(new_school.created_at.to_s)
    end
  end
end
