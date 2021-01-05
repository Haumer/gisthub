class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.public_group || record.members.include?(user)
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

  def logged_in_and_owner_or_admin?
    user_logged_in? ? user_is_owner? || user_is_admin? : false
  end

  private

  def user_logged_in?
    !user.nil?
  end

  def user_is_owner?
    record.user == user
  end

  def user_is_admin?
    user&.admin
  end
end
