class GroupGistsController < ApplicationController
  def create
    @group_gist = GroupGist.new(group: find_group, user: current_user)
    @group_gist.save!
    raise
  end

  private

  def find_group
    Group.find(params.require("group_gist").permit(:group)[:group].to_i)
  end
end
