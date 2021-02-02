class GroupsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_group, only: [ :show, :edit, :update, :destroy ]

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    @group.user = current_user
    if @group.save!
      Usergroup.create(group: @group, user: current_user)
      redirect_back(fallback_location: user_path(slug: @group.user.githubname))
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(update_group_params)
      redirect_back(fallback_location: root_path)
    else
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
    @user = @group.owner
    @group_gists = @group.gists
    if @group.page_counter.nil?
      @group.page_counter = 1
    else
      @group.page_counter += 1
    end
    @group.save
  end

  def archive
    @group = Group.find(params[:group_id])
    @group.update(archived: !@group.archived)
    authorize @group
    redirect_back(fallback_location: current_user.githubname)
  end

  def destroy
    @group.destroy
    redirect_to user_path(slug: current_user.githubname)
  end

  private

  def set_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def update_group_params
    params.require(:group).permit(:name, :alias, :slug, :color, :public_group, :description)
  end
end
