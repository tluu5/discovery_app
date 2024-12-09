module ApplicationHelper
  def display_footer?
    # Add pages where you don't want the footer
    !(controller_name == "sessions" && action_name == "new")
  end
end
