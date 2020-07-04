class Group < ApplicationRecord
  belongs_to :user
  has_many :gists, through: :user
end
