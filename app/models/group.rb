class Group < ApplicationRecord
  belongs_to :user
  has_many :usergroups, dependent: :destroy
  has_many :group_gists, dependent: :destroy
  has_many :user_gists, through: :group_gists
  has_many :users, through: :usergroups, source: :user

  validates :name, presence: true, length: { minimum: 2 }
  validates :slug, length: { minimum: 2 }, format: { with: /.(\d+)./,
    message: "only allows letters" }, on: :update

  def slug_changed?
    !slug.blank?
  end

  def gists
    # users.map(&:user_gists).flatten.reject(&:hide).sort_by(&:updated_at).reverse
    user_gists.reject(&:hide).sort_by(&:updated_at).reverse
  end
end
