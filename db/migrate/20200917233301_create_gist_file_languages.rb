class CreateGistFileLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :gist_file_languages do |t|
      t.references :gist_file, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
