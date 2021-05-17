class School < ApplicationRecord
  has_many :students, dependent: :delete_all

  def students_by (params)
    return students.order(:name) if params[:sort_by_name]
    return students.where("age > #{params[:age]}") if params[:age]
    students
  end

  def pursued_degrees
    students.each_with_object([]) do |student, degrees|
      degrees << student.degree
    end.sort.uniq
  end

  def remote?
    is_remote?? 'Yes' : 'No'
  end
end
