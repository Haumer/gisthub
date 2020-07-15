module ApplicationHelper
  def controller_is_users_show?(params)
    params[:controller] == "users" && params[:action] == "show"
  end
end
