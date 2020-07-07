class UsersController < ApplicationController
  def show
    @user = User.find_by_githubname(params[:slug])
    authorize @user
    @star_gists = @user.user_gists.where(star: true, hide: false).order(date: :desc)
    @gists = @user.user_gists.where(hide: false).order(date: :desc) - @star_gists
  end

  def get_gists
    @user = User.find_by_githubname(params[:slug])
    authorize @user
    count = @user.user_gists.count
    Github::Gists::Api.new(@user).save_gists
    new_gists_count = (@user.user_gists.count - count).positive? ? (@user.user_gists.count - count) : 0

    redirect_to user_user_gists_path(user_slug: @user.githubname, new_gists_count: new_gists_count)
  end
end
