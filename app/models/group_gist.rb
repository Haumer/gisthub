class GroupGist < ApplicationRecord
  belongs_to :group
  belongs_to :user_gist
end
