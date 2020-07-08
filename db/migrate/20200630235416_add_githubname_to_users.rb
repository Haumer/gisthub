class AddGithubnameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :githubname, :string, null: false, default: ""
    add_column :users, :avatar_url, :string, default: "https://avatars3.githubusercontent.com/u/583231?v=4"
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
