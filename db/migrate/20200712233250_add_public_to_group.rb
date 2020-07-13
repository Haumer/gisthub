class AddPublicToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :public_group, :boolean, default: true
  end
end
