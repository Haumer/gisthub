class Group < ApplicationRecord
  belongs_to :user
  has_many :gists, through: :user
  has_many :usergroups, dependent: :destroy
  has_many :users, through: :usergroups, source: :user

  def group_gists
    users.map(&:user_gists).flatten.reject(&:hide).sort_by(&:updated_at).reverse
  end
end
