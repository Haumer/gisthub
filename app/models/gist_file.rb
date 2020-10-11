class GistFile < ApplicationRecord
  belongs_to :user_gist
  has_many :gist_file_language, dependent: :destroy
  has_one :language, through: :gist_file_language
end
