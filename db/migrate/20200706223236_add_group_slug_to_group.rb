class AddGroupSlugToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :slug, :string, default: ""
    add_column :groups, :alias, :string, default: nil
    add_column :groups, :color, :string, default: "#000000"
  end
end
