class Label < ApplicationRecord
  has_many :gist_labels, dependent: :destroy
  belongs_to :user
end
