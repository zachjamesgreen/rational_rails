module ApplicationHelper
  def current_option(yes_selected)
    if yes_selected
      "<option value='true' selected>Yes</option>
      <option value='false'>No</option>".html_safe
    else
      "<option value='true'>Yes</option>
      <option value='false' selected>No</option>".html_safe
    end
  end
end
