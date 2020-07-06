class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def get_gists?
    !user.nil? && user.githubname.present?
  end
end
