class UserGist < ApplicationRecord
  belongs_to :user
  has_many :gist_files, dependent: :destroy
  has_many :gist_labels, dependent: :destroy
  has_many :group_gists, dependent: :destroy
  has_many :groups, through: :group_gists
  has_many :labels, through: :gist_labels

  def languages
    gist_files.pluck(:language).uniq
  end

  def languages_percent
    all = gist_files.pluck(:language, :size)
    languages = Hash.new(0.000)
    all.map do |language|
      languages[language.first] += (language.last.to_f / gist_files.pluck(:size).sum.to_f) * 100
    end
    languages
  end
  # emmbed: <script src="https://gist.github.com/barangerbenjamin/bed924d3f1028f2f9b4596526a94d169.js"></script>
end
