class AddAutoImportToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auto_import, :boolean, default: true
    add_column :users, :stop_import, :boolean, default: false
    add_column :users, :only_group_import, :boolean, default: false
  end
end
