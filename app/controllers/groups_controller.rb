class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save!
      Usergroup.create(group: @group, user: current_user)
      redirect_to user_path(slug: @group.user.githubname)
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
    @group_gists = @group.group_gists
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
