class GroupGistsController < ApplicationController
  def create
    @group_gist = GroupGist.create(group_gist_params)
    authorize @group_gist
    @group_gist.save!
    redirect_back(fallback_location: root_path)
  end

  private

  def group_gist_params
    params.require("group_gist").permit(:group_id, :user_gist_id)
  end
end
