class AddGithubTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github_token, :string, default: nil
  end
end
