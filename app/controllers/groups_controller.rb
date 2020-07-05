class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save!
      redirect_to user_path(slug: @group.user.githubname)
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
