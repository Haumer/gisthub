class AddfieldsToGist < ActiveRecord::Migration[6.0]
  def change
    add_column :user_gists, :url, :string, null: false, default: ""
    add_column :user_gists, :forks_url, :string, null: false, default: ""
    add_column :user_gists, :html_url, :string, null: false, default: ""
    add_column :user_gists, :public, :boolean, null: false, default: true
    add_column :user_gists, :description, :string, default: ""
    add_column :user_gists, :comments, :integer, null: false, default: 0
    add_column :user_gists, :comments_url, :string, null: false, default: ""
    add_column :user_gists, :date, :string, null: false, default: ""
    add_column :user_gists, :gist_id, :string, null: false, default: ""
    add_column :user_gists, :hide, :boolean, default: false
    add_column :user_gists, :star, :boolean, default: false
  end
end
