class CreateGistFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :gist_files do |t|
      t.references :gist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
