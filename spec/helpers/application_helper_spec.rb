require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#current_option' do
    it 'returns html with the yes option selected if param is true' do
      helper.current_option(true).should eq ("<option value='true' selected>Yes</option>
      <option value='false'>No</option>".html_safe)
    end

    it 'returns html with the no option selected if param is false' do
      helper.current_option(false).should eq ("<option value='true'>Yes</option>
      <option value='false' selected>No</option>".html_safe)
    end
  end
end
