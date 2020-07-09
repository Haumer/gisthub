class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user_logged_in?
  end

  def update?
    user_is_owner?
  end

  def logged_in_and_owner?
    user_logged_in? && user_is_owner?
  end

  private


  def user_logged_in?
    !user.nil?
  end

  def user_is_owner?
    record.user == user
  end
end
