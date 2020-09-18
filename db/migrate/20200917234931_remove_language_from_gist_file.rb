class RemoveLanguageFromGistFile < ActiveRecord::Migration[6.0]
  def change
    GistFile.all.each do |file|
      GistFileLanguage.create(gist_file: file, language: Language.find_by_name(file.language))
    end

    remove_column :gist_files, :language
  end
end
