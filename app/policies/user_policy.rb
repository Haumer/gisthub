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

  def import_settings?
    user_owns_profile_or_admin?
  end

  def get_gists?
    !user.nil? && user.githubname.present? || user_owns_profile_or_admin?
  end

  def dashboard?
    admin?
  end

  def import_for_group?
    admin?
  end

  def admin_create?
    admin?
  end

  private

  def user_owns_profile_or_admin?
    user_owns_profile? || admin?
  end

  def user_owns_profile?
    record == user
  end

  def admin?
    user&.admin
  end
end
