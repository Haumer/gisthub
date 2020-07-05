class GistLabel < ApplicationRecord
  belongs_to :label
  belongs_to :user_gist
end
