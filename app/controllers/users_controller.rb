class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :get_gists ]

  def show
    @star_gists = @user.user_gists.where(star: true, hide: false).order(date: :desc)
    @gists = @user.user_gists.where(hide: false).order(date: :desc) - @star_gists
  end

  def admin_create
    @user = User.new(create_params)
    @user.email = "#{@user.githubname}@hubgist.com"
    @user.password = "123456"
    authorize @user
    if @user.save!
      flash[:notice] = "Successfully Created #{@user.githubname}!"
      redirect_to dashboard_path
    else
      flash[:error] = "That didnt work!"
      redirect_to dashboard_path
    end
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
    CheckForUserGistsJob.perform_now(user_id: @user.id)
    new_gists_count = (@user.user_gists.count - count).positive? ? (@user.user_gists.count - count) : 0

    redirect_to user_user_gists_path(user_slug: @user.githubname, new_gists_count: new_gists_count)
  end

  def dashboard
    authorize current_user
  end

  def import_for_group
    authorize current_user
    if import_params.permitted?
      ImportForGroupJob.perform_now(
        import_params[:user_id]
      )
      flash[:notice] = "Successfully imported!"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def create_params
    params.require(:user).permit(:githubname)
  end

  def import_params
    params.require(:import).permit(:user_id)
  end

  def set_user
    @user = User.find_by_githubname(params[:slug])
    authorize @user
  end

  def strong_params
    params.require(:user).permit(:auto_import, :only_group_import, :stop_import)
  end
end
