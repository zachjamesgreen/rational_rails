class SchoolsController < ApplicationController
  def index
    @schools = School.order(:created_at)
  end

  def show
    @school = School.find(params[:id])
  end

  def students
    @school = School.find(params[:id])
  end
end
