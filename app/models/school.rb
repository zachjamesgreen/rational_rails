class School < ApplicationRecord
  has_many :students, dependent: :delete_all

  def students_by (params)
    sort_by_params = students
    sort_by_params = sort_by_params.order(:name) if params[:sort_by_name]
    sort_by_params = sort_by_params.where("age > #{params[:age]}") if params[:age]
    sort_by_params
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
