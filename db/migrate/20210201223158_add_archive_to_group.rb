class AddArchiveToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :archived, :boolean, default: false
  end
end
