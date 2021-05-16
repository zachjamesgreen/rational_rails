require 'rails_helper'

RSpec.describe 'The show school page,' do
  it 'has a title'
  describe 'attributes of the school,' do
    it 'has expected headers'
    it 'shows the attributes'
  end
  describe 'clickable buttons,' do
    describe 'Add Student,' do
      it 'navigates to /schools/:id/students/new'
    end

    describe 'View Students,' do
      it 'navigates to /schools/:id/students'
    end

    describe 'Update,' do
      it 'navigates to /schools/:id/edit'
    end

    describe 'Delete,' do
      it 'deletes school and will not be visible anymore at /schools'
    end
  end
end
