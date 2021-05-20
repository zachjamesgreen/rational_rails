require 'rails_helper'

RSpec.describe 'The school index page,' do
  before :all do
    @school_2 = School.create!(name:'MSU Denver', is_remote:false, school_code:3)
    @school_1 = School.create!(name:'Turing', is_remote: true, school_code:1)
  end

  before :each do
    visit '/schools'
  end

  after :all do
    School.destroy_all
  end

  it 'has a title' do
    title = page.find('h2')

    expect(title).to have_content('List of All Schools')
    expect(title).to appear_before(page.find('#schools_table'))
  end

  describe 'clickable button' do
    describe 'Add school,' do
      it 'should be seen at the top of the page' do
        within '#header_table' do
          expect(page.find('a')).to have_content('Add New School')
        end
      end

      it 'redirects the user to /schools/new' do
        page.find('#add_school_btn').click
        current_path.should eq '/schools/new'
      end
    end

    describe 'Edit school,' do
      it 'should be seen next to each school' do
        within "#button_row_#{@school_1.id}" do
          expect(page.find("#edit_school_#{@school_1.id}_btn")).to have_content('Edit')
        end
      end

      it 'redirects the user to /schools/:id/edit' do
        page.find("#edit_school_#{@school_1.id}_btn").click
        current_path.should eq "/schools/#{@school_1.id}/edit"
      end
    end

    describe 'Delete school,' do
      before :all do
        @test_school = School.create!(name: 'Greg University', is_remote: false, school_code: 10)
      end

      after :all do
        @test_school.destroy!
      end

      it 'should be seen next to each school' do
        delete_button = page.find("#delete_school_#{@test_school.id}_btn")
        expect(delete_button).to have_content('Delete')
      end

      it 'redirects the user to /schools and will no longer see the school listed' do

        delete_button = page.find("#delete_school_#{@test_school.id}_btn")

        within '#schools_table' do
          expect(page).to have_content(@test_school.name)
        end

        delete_button.click

        current_path.should eq '/schools'

        within '#schools_table' do
          expect(page).not_to have_content(@test_school.name)
        end
      end
    end
  end

  describe 'schools list,' do
    it 'has all the schools listed in decending order by creation date' do
      schools_table = page.find(:id, 'schools_table')

      school_row_1 = find("#school_data_row_#{@school_1.id}")
      school_row_2 = find("#school_data_row_#{@school_2.id}")

      within '#schools_table' do
        expect(page).to have_content('School Name')
        expect(page).to have_content('Creation Date')
        expect(school_row_1).to have_content(@school_1.name)
        expect(school_row_1).to have_content(@school_1.created_at.to_s)
        expect(school_row_2).to have_content(@school_2.name)
        expect(school_row_2).to have_content(@school_2.created_at.to_s)
      end

      expect(school_row_1).to appear_before(school_row_2)
    end
  end
end
