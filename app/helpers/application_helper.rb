module ApplicationHelper
  def controller_is_users_show?(params)
    params[:controller] == "users" && params[:action] == "show"
  end

  def user_rank(rank)
    case rank
    when 1 then "gold"
    when 2 then "silver"
    when 3 then "bronze"
    end
  end

  def active?(path, controller)
    # FIXME (haumer): rework
    if controller == path
      "active"
    end
  end
end
