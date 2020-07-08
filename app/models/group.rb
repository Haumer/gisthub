class Group < ApplicationRecord
  after_create :set_default_slug

  belongs_to :user
  has_many :usergroups, dependent: :destroy
  has_many :group_gists, dependent: :destroy
  has_many :user_gists, through: :group_gists
  has_many :users, through: :usergroups, source: :user

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :slug, length: { minimum: 2 }, format: { with: /.(\d+)./,
    message: "only allows letters" }, on: :update, uniqueness: true

  def slug_changed?
    !slug.blank?
  end

  def set_default_slug
    set_slug = ""
    10.times { set_slug += (("a".."z").to_a + ("1".."9").to_a).sample }
    self.update(slug: set_slug)
    # raise
  end

  def gists
    # users.map(&:user_gists).flatten.reject(&:hide).sort_by(&:updated_at).reverse
    user_gists.reject(&:hide).sort_by(&:updated_at).reverse
  end

  def members
    users
  end
end
