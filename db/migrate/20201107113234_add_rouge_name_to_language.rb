class AddRougeNameToLanguage < ActiveRecord::Migration[6.0]
  def change
    add_column :languages, :rouge_name, :string, default: nil
  end
end
