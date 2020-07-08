class AddGroupSlugToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :slug, :string
    add_column :groups, :alias, :string, default: nil
    add_column :groups, :color, :string, default: "#fff"
  end
end
