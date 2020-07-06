class GroupsController < ApplicationController
  before_action :set_group, only: [ :show, :edit, :update ]

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

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_back(fallback_location: root_path)
    else
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
    @group_gists = @group.gists
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :alias, :slug)
  end
end
