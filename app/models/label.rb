class Label < ApplicationRecord
  has_many :gist_labels
  belongs_to :user
end
