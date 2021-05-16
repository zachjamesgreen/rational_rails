require './app/models/school'

class StudentsController < ApplicationController
  def new
    @school_id = params[:id]
  end

  def create
    school = School.find(params[:id])
    school.students.create(student_params)
    redirect_to "/schools/#{params[:id]}/students"
  end

  def index
    @students = Student.order(:name).where(is_alumni: true)
  end

  def show
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @student.update_attributes(student_params)
    redirect_to "/students/#{params[:id]}"
  end

  def edit
    @student = Student.find(params[:id])
  end

  def destroy
    if params[:student]
      Student.destroy(params[:student][:id])
      redirect_to "/schools/#{params[:id]}/students"
    else
      Student.destroy(params[:id])
      redirect_to '/students'
    end
  end

  private

  def student_params
    if params[:student]
      params.require(:student).permit(:name, :age, :degree, :is_alumni)
    end
  end

end
