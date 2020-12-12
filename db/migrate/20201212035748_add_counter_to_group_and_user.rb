class AddCounterToGroupAndUser < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :page_counter, :integer, defautl: 0
    add_column :users, :page_counter, :integer, defautl: 0
  end
end
