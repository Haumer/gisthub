class GistLabelPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    user_logged_in?
  end

  private

  def user_logged_in?
    !user.nil?
  end
end
