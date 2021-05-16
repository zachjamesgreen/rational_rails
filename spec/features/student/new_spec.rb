require 'rails_helper'

RSpec.describe 'The new student page,' do
  it 'has a title'
  describe 'form,' do
    it 'has labels for each input'
    it 'has a submit button'
  end
  describe 'submit button,' do
    it 'navigates back to /schools/:id/students and the new school is visable'
  end
end
