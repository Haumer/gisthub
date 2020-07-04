class GistLabel < ApplicationRecord
  belongs_to :label
  belongs_to :gist
end
