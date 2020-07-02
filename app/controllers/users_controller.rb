class UsersController < ApplicationController
  def show
    @user = User.find_by_githubname(params[:slug])
    @gists = @user.gists.order(date: :desc)
  end

  def get_gists
    @user = User.find_by_githubname(params[:slug])
    @user.get_gists
    redirect_to user_path(slug: @user.githubname)
  end
end
