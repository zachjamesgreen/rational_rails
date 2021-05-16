require 'rails_helper'

RSpec.describe 'The show school page,' do
  it 'has a title'
  describe 'attributes of the school,' do
    it 'has expected headers'
    it 'shows the attributes'
  end
  describe 'clickable buttons,' do
    describe 'Edit,' do
      it 'navigates to /schools/:id/edit'
    end
  end
end
