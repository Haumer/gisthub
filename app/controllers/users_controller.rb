class UsersController < ApplicationController
  def show
    @user = User.find_by_githubname(params[:slug])
    @star_gists = @user.gists.where(star: true, hide: false).order(date: :desc)
    @gists = @user.gists.where(hide: false).order(date: :desc) - @star_gists
  end

  def get_gists
    @user = User.find_by_githubname(params[:slug])
    count = @user.gists.count
    @user.get_gists
    new_gists_count = (@user.gists.count - count).positive? ? (@user.gists.count - count).positive? : 0

    redirect_to user_path(slug: @user.githubname, new_gists_count: new_gists_count)
  end
end
