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
  end

  describe 'clickable button' do
    describe 'Add school,' do
      before :each do
        top_table = page.find(:id, 'header_table')
        @create_button = top_table.find('a')
      end
      it 'should be seen at the top of the page' do
        expect(@create_button.text).to eq 'Add New School'
      end

      it 'redirects the user to /schools/new' do
        @create_button.click
        current_path.should eq '/schools/new'
      end
    end

    describe 'Edit school,' do
      before :each do
        schools_table = page.find(:id, 'schools_table')
        @edit_button = schools_table.find(:id, "edit_school_#{@school_1.id}_btn")
      end

      it 'should be seen next to each school' do
        expect(@edit_button).to have_content('Edit')
      end

      it 'redirects the user to /schools/:id/edit' do
        @edit_button.click
        current_path.should eq "/schools/#{@school_1.id}/edit"
      end
    end

    describe 'Delete school,' do
      before :all do
        @test_school = School.create!(name: 'Greg University', is_remote: false, school_code: 10)
      end

      before :each do
        @schools_table = page.find(:id, 'schools_table')
      end

      after :all do
        @test_school.destroy!
      end

      it 'should be seen next to each school' do
        delete_button = @schools_table.find(:id, "delete_school_#{@test_school.id}_btn")
        expect(delete_button).to have_content('Delete')
      end

      it 'redirects the user to /schools and will no longer see the school listed' do
        table_rows = @schools_table.find_all('tr')
        delete_button = @schools_table.find(:id, "delete_school_#{@test_school.id}_btn")

        expected_data_seen_before_deletion = [
          [@test_school.name, @test_school.created_at.to_s],
          [@school_1.name, @school_1.created_at.to_s],
          [@school_2.name, @school_2.created_at.to_s]]

        expected_data_seen_after_deletion = [
          [@school_1.name, @school_1.created_at.to_s],
          [@school_2.name, @school_2.created_at.to_s]]

        actual_data_seen_before_deletion = table_rows.filter_map do |row|
          table_data = row.find_all('td')
          table_data.map(&:text) if table_data.length > 1
        end

        expect(actual_data_seen_before_deletion).to eq expected_data_seen_before_deletion

        delete_button.click

        table_rows = @schools_table.find_all('tr')

        actual_data_seen_after_deletion = table_rows.filter_map do |row|
          table_data = row.find_all('td')
          table_data.map(&:text) if table_data.length > 1
        end

        current_path.should eq '/schools'
        expect(actual_data_seen_after_deletion).to eq expected_data_seen_after_deletion
      end
    end
  end

  describe 'schools list,' do
    it 'has all the schools listed' do
      schools_table = page.find(:id, 'schools_table')
      table_rows = schools_table.find_all('tr')

      expected_data_seen = [
        [@school_1.name, @school_1.created_at.to_s],
        [@school_2.name, @school_2.created_at.to_s]]

      actual_data_seen = table_rows.filter_map do |row|
        table_data = row.find_all('td')
        table_data.map(&:text) if table_data.length > 1
      end

      expected_headers_seen = ['School Name', 'Creation Date']

      actual_headers_seen = table_rows.first.find_all('th').map(&:text)

      expect(actual_data_seen).to eq expected_data_seen
      expect(actual_headers_seen).to eq expected_headers_seen
    end
  end
end
