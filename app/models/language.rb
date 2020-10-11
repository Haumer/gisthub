class Language < ApplicationRecord
  has_many :gist_file_languages, dependent: :destroy
  has_many :gist_files, through: :gist_file_languages
end
