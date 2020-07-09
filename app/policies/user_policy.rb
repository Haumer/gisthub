class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    user_owns_profile_or_admin?
  end

  def get_gists?
    !user.nil? && user.githubname.present? || user_owns_profile_or_admin?
  end

  def user_owns_profile_or_admin?
    record == user || user.admin
  end
end
