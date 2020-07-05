class Group < ApplicationRecord
  belongs_to :user
  has_many :gists, through: :user
  has_many :usergroups, dependent: :destroy
  has_many :users, through: :usergroups, source: :user
end
