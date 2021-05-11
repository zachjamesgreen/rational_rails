class StudentsController < ApplicationController
  def index
    @students = Student.order(:name).where(is_alumni: true)
  end

  def new
    @school_id = params[:id]
  end

  def create
    attrs = params[:student]
    Student.create(name: attrs[:name],
                   badge_code: attrs[:badge_code],
                   is_alumni: attrs[:is_alumni],
                   degree: attrs[:degree],
                   school_id: params[:id])

    redirect_to "/schools/#{params[:id]}/students"
  end

  def show
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @student.update_attributes(student_params)
    @student.save
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
      params.require(:student).permit(:name, :badge_code, :degree, :is_alumni)
    end
  end

end
