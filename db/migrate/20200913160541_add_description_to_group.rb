class AddDescriptionToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :description, :text, default: ""
  end
end
