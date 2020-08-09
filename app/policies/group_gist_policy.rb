class GroupGistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.group.members.include?(user) || user.admin
  end
end
