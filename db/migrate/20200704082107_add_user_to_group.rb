class AddUserToGroup < ActiveRecord::Migration[6.0]
  def change
    add_reference :groups, :user, foreign_key: true
    add_reference :labels, :user, foreign_key: true
  end
end
