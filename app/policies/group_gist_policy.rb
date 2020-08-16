class GroupGistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.group.members.include?(user) || user.admin || is_personal_group
  end

  private

  def is_personal_group
    record.group == user.personal_group
  end
end
