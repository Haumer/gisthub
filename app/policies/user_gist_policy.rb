class UserGistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def index?
    true
  end

  def destroy?
    admin_is_owner_or_admin?
  end

  def create?
    user_logged_in?
  end

  def update?
    admin_is_owner_or_admin?
  end

  def toggle_star?
    admin_is_owner_or_admin?
  end

  def toggle_hide?
    admin_is_owner_or_admin?
  end

  private

  def admin_is_owner_or_admin?
    user_logged_in? ? user_is_admin? : false
  end

  def user_logged_in?
    !user.nil?
  end

  def user_is_admin?
    user.admin?
  end
end
