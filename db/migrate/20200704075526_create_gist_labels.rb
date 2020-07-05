class CreateGistLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :gist_labels do |t|
      t.references :label, null: false, foreign_key: true
      t.references :user_gist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
