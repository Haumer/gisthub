class UsergroupsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @usergroup = Usergroup.new(user: User.find(strong_params["user"].to_i))
    @usergroup.group = @group
    authorize @usergroup
    if @usergroup.save!
      flash[:notice] = "Success"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def strong_params
    params.require(:usergroup).permit(:user)
  end
end
