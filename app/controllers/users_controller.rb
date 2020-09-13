class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :get_gists ]
  before_action :group_search, only: [ :dashboard ]

  def show
    @star_gists = @user.user_gists.where(star: true, hide: false).order(date: :desc)
    if search_params
      @gists = policy_scope(UserGist).global_search(search_params[:keyword]).where(user: @user, hide: false) - @star_gists
    else
      @gists = policy_scope(UserGist).where(user: @user, hide: false).order(date: :desc) - @star_gists
    end
  end

  def admin_create
    @user = User.new(create_params)
    @user.email = "#{@user.githubname}@hubgist.com"
    @user.password = "12345678"
    authorize @user
    if @user.save!
      flash[:notice] = "Successfully Created #{@user.githubname}!"
      redirect_to admin_dashboard_path
    else
      flash[:error] = "That didnt work!"
      redirect_to admin_dashboard_path
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
    # raise
    @user = current_user
    authorize current_user
    @groups = (@user.groups + @user.usergroups.map(&:group)).uniq
    if group_search.present?
      @groups = @groups.group_search(group_search[:keyword]) if group_search[:keyword].present?
    end

    @users = @user.groups.map(&:members).flatten.uniq
    @gists = @users.map {|user| user.user_gists}.flatten.uniq.group_by_day(&:date).to_a.reverse
  end

  def admin_dashboard
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

  def group_search
    return unless params[:group_search].present?
    params.require(:group_search).permit(:keyword)
  end

  def search_params
    params.require(:search).permit(:keyword) if params[:search].present? && !params[:search][:keyword].empty?
  end

  def create_params
    params.require(:user).permit(:githubname)
  end

  def import_params
    params.require(:import).permit(:user_id)
  end

  def set_user
    @user = User.find_by_githubname(params[:slug]) || current_user
    authorize @user
  end

  def strong_params
    params.require(:user).permit(:auto_import, :only_group_import, :stop_import)
  end
end
