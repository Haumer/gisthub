class AddMarkdownPermissionToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :markdown_permission, :boolean, default: false
    add_column :gist_files, :markdown_display, :boolean, default: false
  end
end
