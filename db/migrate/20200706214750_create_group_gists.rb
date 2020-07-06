class CreateGroupGists < ActiveRecord::Migration[6.0]
  def change
    create_table :group_gists do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user_gist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
