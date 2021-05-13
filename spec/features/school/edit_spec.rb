require 'rails_helper'

RSpec.describe 'the school edit' do
  describe 'page' do
    before :all do
      @turing_school = School.create!(name: 'Turing', school_code: 1, is_remote: true)
      @msu_school = School.create!(name: 'MSU Denver', school_code: 2, is_remote: false)
    end

    it 'shows a title with the school name' do
      visit "/schools/#{@turing_school.id}/edit"

      page_title = page.find('h2')

      expect(page_title).to have_content("Edit School #{@turing_school.name}")

      visit "/schools/#{@msu_school.id}/edit"

      page_title = page.find('h2')

      expect(page_title).to have_content("Edit School #{@msu_school.name}")
    end


    describe 'form' do
      it 'is present' do
        visit "/schools/#{@turing_school.id}/edit"
        expect(page.find('form')).to be_present
      end

      it 'has populated fields of the school' do
        visit "/schools/#{@turing_school.id}/edit"

        expect(page.find(:id, 'school_name').value).to eq('Turing')
        expect(page.find(:id, 'school_code').value).to eq('1')
        expect(page.find(:id, 'school_is_remote').value).to eq('true')

        visit "/schools/#{@msu_school.id}/edit"

        expect(page.find(:id, 'school_name').value).to eq('MSU Denver')
        expect(page.find(:id, 'school_code').value).to eq('2')
        expect(page.find(:id, 'school_is_remote').value).to eq('false')
      end

      it 'navigates back to the edited school when form is submitted' do
        visit "/schools/#{@turing_school.id}/edit"

        within 'form' do
          find(:id, 'submit_button').click
        end
        current_path.should eq "/schools/#{@turing_school.id}"
      end
    end
  end
end
