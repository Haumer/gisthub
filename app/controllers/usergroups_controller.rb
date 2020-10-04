class UsergroupsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @user = User.find(strong_params["user"].to_i
    @usergroup = Usergroup.new(user: @user))
    @usergroup.group = @group
    authorize @usergroup
    if @usergroup.save!
      flash[:notice] = "#{@user.githubname} was successfully added!"
      redirect_back(fallback_location: @group)
    else
      flash[:error] = "Ooops, looks like something went wrong!"
      redirect_back(fallback_location: @group)
    end
  end

  private

  def strong_params
    params.require(:usergroup).permit(:user)
  end
end
