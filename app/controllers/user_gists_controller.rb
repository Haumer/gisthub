class UserGistsController < ApplicationController
  def create
    @gist = UserGist.create(gist_params)
  end

  def index
    @user = User.find_by_githubname(params[:user_slug])
    @gists = @user.user_gists.order(date: :desc)
  end

  def hide
    @gist = UserGist.find(params[:id])
    @gist.update(hide: !@gist.hide)
    redirect_back(fallback_location: user_path(current_user.githubname))
  end

  def star
    @gist = UserGist.find(params[:id])
    @gist.update(star: !@gist.star)
    redirect_back(fallback_location: user_path(current_user.githubname))
  end

  private

  def gist_params
    params.require(:gist).permit()
  end
end
