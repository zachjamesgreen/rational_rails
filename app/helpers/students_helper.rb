module StudentsHelper
  def current_option(is_alumni)
    if is_alumni
      "<option value='true' selected>Yes</option>
      <option value='false'>No</option>".html_safe
    else
      "<option value='true'>Yes</option>
      <option value='false' selected>No</option>".html_safe
    end
  end
end
