class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @top_gist_users = User.joins(:user_gists).group('users.id').order("count(users.id) DESC").limit(5)
    # FIXME (haumer): convert into sql query
    top_lines_users = User.all.map do |user|
      [user, [user.user_gists&.map { |gist| gist.gist_files.pluck(:size) }.sum].flatten.sum ]
    end
    @top_lines_users = top_lines_users.sort_by do |info|
      -info.last
    end.first(5)

    @languages = GistFile.group(:language).count(:language).sort_by { |l, v| -v }.first(5)
  end

  def howto
  end
end
