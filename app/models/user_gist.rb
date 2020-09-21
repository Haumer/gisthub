class UserGist < ApplicationRecord
  belongs_to :user
  has_many :gist_files, dependent: :destroy
  has_many :gist_labels, dependent: :destroy
  has_many :group_gists, dependent: :destroy
  has_many :groups, through: :group_gists
  has_many :labels, through: :gist_labels

  acts_as_votable

  def languages
    gist_files.pluck(:language).uniq
  end

  def gist_filenames
    gist_files.map(&:filename).join(" ")
  end

  def languages_percent
    all = gist_files.pluck(:language, :size)
    languages = Hash.new(0.000)
    all.map do |language|
      languages[language.first] += (language.last.to_f / gist_files.pluck(:size).sum.to_f) * 100
    end
    languages
  end

  def groups_of_owner
    groups.where(user: self.user)
  end

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :description ],
    associated_against: {
      gist_files: [ :filename ],
      groups: [ :slug ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
