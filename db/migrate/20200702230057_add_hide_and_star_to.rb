class AddHideAndStarTo < ActiveRecord::Migration[6.0]
  def change
    add_column :gists, :hide, :boolean, default: true
    add_column :gists, :star, :boolean, default: true
  end
end
