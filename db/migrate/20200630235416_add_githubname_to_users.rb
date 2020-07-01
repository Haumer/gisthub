class AddGithubnameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :githubname, :string, null: false, default: ""
  end
end
