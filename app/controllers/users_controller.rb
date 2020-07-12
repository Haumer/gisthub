class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :get_gists ]

  def show
    @star_gists = @user.user_gists.where(star: true, hide: false).order(date: :desc)
    @gists = @user.user_gists.where(hide: false).order(date: :desc) - @star_gists
  end

  def edit
  end

  def update
    if @user.update(strong_params)
      flash[:notice] = "Successfully updated!"
      redirect_back(fallback_location: user_path(slug: @user.githubname))
    else
      flash[:error] = "Something went wrong!"
      redirect_back(fallback_location: user_path(slug: @user.githubname))
    end
  end

  def get_gists
    count = @user.user_gists.count
    Github::Gists::Api.new(@user).save_gists
    new_gists_count = (@user.user_gists.count - count).positive? ? (@user.user_gists.count - count) : 0

    redirect_to user_user_gists_path(user_slug: @user.githubname, new_gists_count: new_gists_count)
  end

  private

  def set_user
    @user = User.find_by_githubname(params[:slug])
    authorize @user
  end

  def strong_params
    params.require(:user).permit(:auto_import, :only_group_import, :stop_import)
  end
end
