
class UserGistsController < ApplicationController
  after_action :authorize_gist, only: [ :create, :toggle_hide, :toggle_star ]

  def create
    @gist = UserGist.create(gist_params)
  end

  def index
    @user = User.find_by_githubname(params[:user_slug])
    search_params ? @gists = policy_scope(UserGist).global_search(search_params[:keyword]).where(user: @user) :
      @gists = policy_scope(UserGist).where(user: @user).order(date: :desc)
  end

  def show
    @gist = UserGist.find(params[:id])
    authorize @gist
    @user = User.find_by_githubname(params[:user_slug])
  end

  def destroy
    @gist = UserGist.find(params[:id])
    @user = @gist.user
    authorize @gist
    @gist.destroy
    redirect_back(fallback_location: user_path(slug: @user.githubname))
  end

  def toggle_hide
    @gist = UserGist.find(params[:id])
    @gist.update(hide: !@gist.hide)
    redirect_back(fallback_location: user_path(current_user.githubname))
  end

  def toggle_star
    @gist = UserGist.find(params[:id])
    @gist.update(star: !@gist.star)
    redirect_back(fallback_location: user_path(current_user.githubname))
  end

  def toggle_bookmark
    @gist = UserGist.find(params[:id])
  end

  private

  def search_params
    params.require(:search).permit(:keyword) if params[:search].present? && !params[:search][:keyword].empty?
  end

  def authorize_gist
    authorize @gist
  end

  def gist_params
    params.require(:gist).permit()
  end
end
