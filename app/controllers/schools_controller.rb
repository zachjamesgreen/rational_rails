class SchoolsController < ApplicationController
  def index
    @schools = School.order(created_at: :desc)
  end

  def new
  end

  def create
    attrs = params[:school]
    School.create(name: attrs[:name],
                  school_code: attrs[:school_code],
                  is_remote: attrs[:is_remote])

    redirect_to '/schools'
  end

  def show
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    @school.update_attributes(school_params)
    @school.save
    redirect_to "/schools/#{params[:id]}"
  end

  def edit
    @school = School.find(params[:id])
  end

  def students
    @school = School.find(params[:id])
  end

  def degrees
    @school = School.find(params[:id])
    @current_degrees = @school.students.each_with_object([]) do |student, degrees|
      degrees << student.degree
    end.sort
  end

  private

  def school_params
    if params[:school]
      params.require(:school).permit(:school, :name, :school_code, :is_remote)
    end
  end
end
