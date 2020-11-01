class UserGist < ApplicationRecord
  belongs_to :user
  has_many :gist_files, dependent: :destroy
  has_many :gist_labels, dependent: :destroy
  has_many :group_gists, dependent: :destroy
  has_many :groups, through: :group_gists
  has_many :labels, through: :gist_labels

  acts_as_votable

  def languages
    gist_files.map(&:languages).flatten
  end

  def gist_filenames
    gist_files.map(&:filename).join(" ")
  end

  def languages_percent
    all_languages = Hash.new(0.000)
    gist_files.map do |file|
      all_languages[file.languages.first.name] += (file.size.to_f / gist_files.pluck(:size).sum.to_f) * 100
    end
    all_languages
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
