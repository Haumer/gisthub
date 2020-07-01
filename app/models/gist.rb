class Gist < ApplicationRecord
  belongs_to :user
  has_many :gist_files

  def languages
    gist_files.pluck(:language).uniq
  end

  def languages_percent
    all = gist_files.pluck(:language, :size)
    languages = Hash.new(0.000)
    all.each do |language|
      languages[language.first] += (language.last.to_f / gist_files.pluck(:size).sum.to_f) * 100
    end
    languages
  end
  # emmbed: <script src="https://gist.github.com/barangerbenjamin/bed924d3f1028f2f9b4596526a94d169.js"></script>
end
