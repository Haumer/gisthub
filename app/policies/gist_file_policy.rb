class GistFilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    user_is_owner_or_admin?
  end

  def markdown_permission?
    user_is_owner_or_admin? && user.markdown_permission || user.admin
  end

  def user_is_owner_or_admin?
    record.user_gist.user == user || user.admin
  end
end
