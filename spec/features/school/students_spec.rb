require 'rails_helper'

RSpec.describe 'The list of students for school,' do
  it 'has a title'
  describe 'get students greater than given age form,' do
    it 'can be seen at the top of the list of students'
    describe 'submission button,' do
      it 'has a label'
      it 'submits request and shows new list of students based on given query value'
    end
  end

  describe 'clickable button,' do
    describe 'view student,' do
      it 'is the name of the student and is clickable'
      it 'redirects to /students/:id'
    end
    describe 'Edit student,' do
      it 'can be seen next to each student'
      it 'redirects to /students/:id/edit'
    end
    describe 'Delete student,' do
      it 'can be seen next to each student'
      it 'deletes student and redirects to /schools/:id/students without the deleted student listed anymore'
    end
  end
  
  describe 'student list,' do
    it 'has the expected headers'
    it 'shows all students for the school'
  end
end
