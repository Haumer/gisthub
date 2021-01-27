class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user_count = User.count
    @top_gist_users = User.joins(:user_gists).group('users.id').order("count(users.id) DESC").limit(5)
    # FIXME (haumer): convert into sql query
    @top_lines_users = User.all.map do |user|
      [user, user.user_gists&.map { |gist| gist.gist_files.count }.sum ]
    end.sort_by { |info| -info.last }.first(5)

    @minimum_password_length = Devise.password_length.first
    @lastest = UserGist.last(3)
    @languages = Language.limit(5).map { |language| [language, language.lines] }
  end
end
