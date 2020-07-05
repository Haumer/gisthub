class GistsController < ApplicationController
  def create
    @gist = Gist.create(gist_params)
  end

  def index
    @user = User.find_by_githubname(params[:user_slug])
    @gists = @user.gists.order(date: :desc)
  end

  def hide
    @gist = Gist.find(params[:id])
    @gist.update(hide: !@gist.hide)
    redirect_back(fallback_location: user_path(current_user.githubname))
  end

  def star
    @gist = Gist.find(params[:id])
    @gist.update(star: !@gist.star)
    redirect_back(fallback_location: user_path(current_user.githubname))
  end

  private

  def gist_params
    params.require(:gist).permit()
  end
end
