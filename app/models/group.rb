class Group < ApplicationRecord
  after_create :set_default_slug

  belongs_to :user
  has_many :usergroups, dependent: :destroy
  has_many :group_gists, dependent: :destroy
  has_many :user_gists, through: :group_gists
  has_many :users, through: :usergroups, source: :user

  validates :name, presence: true, length: { minimum: 2 }
  validates :slug, length: { minimum: 2 }, format: { with: /([a-zA-Z0-9]{3,})/,
    message: "need at least one letter and one digit" }, on: :update, uniqueness: true

  def slug_changed?
    !slug.blank?
  end

  def set_default_slug
    set_slug = SecureRandom.hex(3)

    self.update(slug: set_slug)
  end

  def gists
    user_gists.reject(&:hide).sort_by(&:date).reverse
  end

  def members
    users
  end

  def owner
    user
  end

  include PgSearch::Model
  pg_search_scope :group_search,
    against: [ :name, :slug ],
    using: {
      tsearch: { prefix: true }
    }
end
