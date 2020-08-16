class AddPersonalToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :personal, :boolean, default: false
  end
end
