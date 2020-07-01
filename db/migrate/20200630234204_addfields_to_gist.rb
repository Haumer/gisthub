class AddfieldsToGist < ActiveRecord::Migration[6.0]
  def change
    add_column :gists, :url, :string, null: false, default: ""
    add_column :gists, :forks_url, :string, null: false, default: ""
    add_column :gists, :html_url, :string, null: false, default: ""
    add_column :gists, :public, :boolean, null: false, default: true
    add_column :gists, :description, :string, default: ""
    add_column :gists, :comments, :integer, null: false, default: 0
    add_column :gists, :comments_url, :string, null: false, default: ""
    add_column :gists, :date, :string, null: false, default: ""
    add_column :gists, :gist_id, :string, null: false, default: ""
  end
end
