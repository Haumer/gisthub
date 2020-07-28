class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @users = User.joins(:user_gists).group('users.id').order("count(users.id) DESC").limit(10)
  end

  def howto
  end
end
