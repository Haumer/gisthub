module Github
  module Gists
    class Api
      def initialize(user)
        @user = user
        @gist_url = "https://api.github.com/users/#{@user.githubname}/gists".freeze
        @data = call_api
      end

      def call_api
        uri = URI(@gist_url)
        JSON.parse(Net::HTTP.get(uri))
      end

      def save_gists
        @data.each do |gist|
          created_gist = UserGist.find_or_create_by(
            gist_id: gist["id"],
            date: gist["created_at"],
            comments_url: gist["comments_url"],
            public: gist["public"],
            html_url: gist["html_url"],
            url: gist["url"],
            forks_url: gist["forks_url"],
            user: @user
          )

          if created_gist
            gist["files"].each do |_k, v|
              GistFile.find_or_create_by(
                filename: v["filename"],
                language: v["language"],
                raw_url: v["raw_url"],
                size: v["size"],
                user_gist: created_gist
              )
            end
          end
        end
        check_gists
      end

      def check_gists
        @data.each do |gist|
          found_gist = UserGist.find_by_gist_id(gist["id"])
          if found_gist
            found_gist.update(
              comments: gist["comments"],
              description: gist["description"]
            )
          end
        end
      end
    end
  end
end
