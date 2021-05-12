module SchoolsHelper
  def current_option(is_remote)
    if is_remote
      "<option value='true' selected>Yes</option>
      <option value='false'>No</option>".html_safe
    else
      "<option value='true'>Yes</option>
      <option value='false' selected>No</option>".html_safe
    end
  end
end
