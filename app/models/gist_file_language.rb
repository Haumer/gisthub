class GistFileLanguage < ApplicationRecord
  belongs_to :gist_file
  belongs_to :language
end
