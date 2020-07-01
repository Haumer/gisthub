class AddFieldstoGistFile < ActiveRecord::Migration[6.0]
  def change
    add_column :gist_files, :filename, :string, default: ""
    add_column :gist_files, :raw_url, :string, default: ""
    add_column :gist_files, :size, :integer, default: 0
    add_column :gist_files, :language, :string, default: ""
  end
end
