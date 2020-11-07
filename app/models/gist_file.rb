class GistFile < ApplicationRecord
  belongs_to :user_gist
  has_many :gist_file_language, dependent: :destroy
  has_many :languages, through: :gist_file_language

  def language
    languages.first
  end
end
