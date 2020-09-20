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

    # if GistFile.all.map(&:language).present?
    #   @languages = GistFile.group(:language).count(:language).sort_by { |l, v| -v }.first(5)
    # else
    #   @languages = []
    # end
  end

  def howto
  end

  # def access
  #   result = RestClient.post("https://github.com/login/oauth/access_token", {
  #     client_id: ENV["DEV_APP_ID"],
  #     client_secret: ENV["DEV_APP_SECRET"],
  #     code: params[:code],
  #     redirect_uri: "http://localhost:3000/access"
  #   })

  #   res = RestClient.post("https://gist.github.com/gists", { access_token: result["access_token"] })

  #   # result = Github::Gists::Api.new(current_user).access
  #   # redirect_back(fallback_location: root_path)
  # end
end
