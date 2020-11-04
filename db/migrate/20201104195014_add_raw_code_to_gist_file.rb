class AddRawCodeToGistFile < ActiveRecord::Migration[6.0]
  def change
    add_column :gist_files, :raw_code, :string, default: nil
  end
end
