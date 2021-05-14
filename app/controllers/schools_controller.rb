class SchoolsController < ApplicationController
  def new
  end

  def create
    School.create(school_params)
    redirect_to '/schools'
  end

  def index
    @schools = School.order(created_at: :desc)
  end

  def show
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    @school.update_attributes(school_params)
    redirect_to "/schools/#{params[:id]}"
  end

  def edit
    @school = School.find(params[:id])
  end

  def destroy
    School.destroy(params[:id])
    redirect_to '/schools'
  end

  def students
    if params[:age]
      @school = School.find(params[:id])
      @students = @school.students.where("age > #{params[:age]}")
    else
      @school = School.find(params[:id])
      @students = @school.students
    end
  end

  def degrees
    @school = School.find(params[:id])
    @current_degrees = @school.students.each_with_object([]) do |student, degrees|
      degrees << student.degree
    end.sort.uniq
  end

  private

  def school_params
    if params[:school]
      params.require(:school).permit(:name, :school_code, :is_remote)
    end
  end
end
