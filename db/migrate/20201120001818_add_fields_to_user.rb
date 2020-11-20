class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sign_in_count, :integer, default: 0
    add_column :users, :current_sign_in_at, :datetime, defautl: nil
    add_column :users, :last_sign_in_at, :datetime, defautl: nil
    add_column :users, :current_sign_in_ip, :string, defautl: nil
    add_column :users, :last_sign_in_ip, :string, defautl: nil
  end
end
