class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :gists

  def gist_api
    gist_url = "https://api.github.com/users/#{self.githubname}/gists".freeze
    uri = URI(gist_url)
    JSON.parse(Net::HTTP.get(uri))
  end

  def get_gists
    gist_api.each do |gist|
      created_gist = Gist.find_or_create_by(
        gist_id: gist["id"],
        date: gist["created_at"],
        comments_url: gist["comments_url"],
        public: gist["public"],
        html_url: gist["html_url"],
        url: gist["url"],
        forks_url: gist["forks_url"],
        user: self
      )

      if created_gist
        gist["files"].each do |_k, v|
          GistFile.find_or_create_by(
            filename: v["filename"],
            language: v["language"],
            raw_url: v["raw_url"],
            size: v["size"],
            gist: created_gist
          )
        end
      end
    end
    check_gists
  end

  def check_gists
    gist_api.each do |gist|
      found_gist = Gist.find_by_gist_id(gist["id"])
      if found_gist
        found_gist.update(
          comments: gist["comments"],
          description: gist["description"]
        )
      end
    end
  end
end
