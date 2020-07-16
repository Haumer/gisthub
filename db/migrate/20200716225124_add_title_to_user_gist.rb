class AddTitleToUserGist < ActiveRecord::Migration[6.0]
  def change
    add_column :user_gists, :title, :string, default: ""
  end
end
