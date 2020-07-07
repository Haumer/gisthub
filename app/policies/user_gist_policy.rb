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

  def create?
    !user.nil?
  end

  def update?
    record.user == user
  end

  def toggle_star?
    record.user == user
  end
end
