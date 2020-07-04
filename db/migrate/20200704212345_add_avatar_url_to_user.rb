class AddAvatarUrlToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_url, :string, default: ""
  end
end
