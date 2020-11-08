module Github
  module Gist
    class Client
      GROUP_SLUG_REGEX = /\A([a-zA-Z]*\d*)_(\w*)\.(\w*)/.freeze
      GIST_URL = "https://gist.github.com"

      def initialize(user)
        @user = user
        @github_api = "https://api.github.com/users/#{@user.githubname}".freeze
        @latest_gist_date = @user.user_gists.present? ?
          @user.user_gists.order(date: :desc).first.date : "2000-00-00T00:00:00Z"
      end

      def get_gists
        response = RestClient.get("#{@github_api}/gists")
        JSON.parse(response)
      end

      def access_token
        uri = URI.parse("https://api.github.com/user")
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "token #{user.github_token}"

        req_options = {
          use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
      end

      def create_gist(gist)
        uri = URI.parse("https://api.github.com/gists")
        request = Net::HTTP::Post.new(uri)
        request["Accept"] = "application/vnd.github.v3+json"
        request["Authorization"] = "token #{user.github_token}"
        request.body = JSON.dump({
          "files" => {}
        })

        req_options = {
          use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
      end

      def edit_gist_url(gist)
        "#{GIST_URL}/#{@user.githubname}/#{gist.gist_id}/edit"
      end

      def gist_url(gist)
        "#{GIST_URL}/#{@user.githubname}/#{gist.gist_id}"
      end

      def build(gist)
        {
          files: {

          }
        }
      end

      def save_gists
        return if @user.stop_import

        @data = get_gists
        @lastest_gist_date
        if !@user.only_group_import
          create_gists
        elsif @user.only_group_import
          return unless found_group_slugs.present?
          @data = found_group_slugs
          create_gists
        end
      end

      private

      def found_group_slugs
        @data.select do |gist|
          gist["files"].select do |k, _v|
            next unless k.match?(GROUP_SLUG_REGEX)

            group_id = k.match(GROUP_SLUG_REGEX)[1]
            @user.groups.pluck(:slug).include?(group_id)
          end.present?
        end
      end

      def create_gists
        return if @data.is_a?(Hash)

        @data.each do |gist|
          next unless gist["updated_at"] > @latest_gist_date
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
            # FIXME: (haumer): if file name changes we dont want dead files
            # so currently we just destory all and recreate. maybe explore
            # comparing and then updating?
            created_gist.gist_files.destroy_all
            created_gist.update(gist_id: gist["id"])
            group = check_for_group(gist)

            if group && group.members.include?(@user)
              GroupGist.find_or_create_by(group: group, user_gist: created_gist)
            end

            @user.update(avatar_url: gist["owner"]["avatar_url"]) if @user.avatar_url == "https://avatars3.githubusercontent.com/u/583231?v=4"

            gist["files"].each do |_k, v|
              file = GistFile.find_or_create_by(
                filename: v["filename"],
                raw_url: v["raw_url"],
                size: v["size"],
                user_gist: created_gist
              )
              language = Language.find_by_name(v["language"])
              if language
                GistFileLanguage.create(language: language, gist_file: file)
              end

              if file.raw_url
                raw_code = Net::HTTP.get(URI(file.raw_url))
                file.update(raw_code: raw_code) if raw_code
              end
            end
          end
        end
        check_gists
      end

      def check_for_group(gist)
        group = gist["files"].map do |k, _v|
          if k.match?(/\A([a-zA-Z]*\d*_)(\w*)\.(\w*)/)
            group_id = k.match(/\A([a-zA-Z]*\d*)_(\w*)\.(\w*)/)[1]
            Group.find_by_slug(group_id)
          end
        end.compact.first
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

  class Api
    def initialize(user)
      @user = user
      @github_url = "https://api.github.com/users/#{@user.githubname}".freeze
      @data = call_api
    end

    def call_api
      uri = URI(@github_url)
      JSON.parse(Net::HTTP.get(uri))
    end

    def valid?
      !@data["message"].nil?
    end

    def fetch_user_img
      @user.update(avatar_url: call_api["avatar_url"])
    end
  end
end
