class UsersController < ApplicationController
  def show
    @user = User.find_by_githubname(params[:slug])
    # @user.get_gists
    @gists = @user.gists
  end
end
