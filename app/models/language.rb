class Language < ApplicationRecord
  has_many :gist_file_languages, dependent: :destroy
  has_many :gist_files, through: :gist_file_languages
  before_create :set_rouge_name

  def set_rouge_name
    downcased_name = name.downcase

    case downcased_name
    when 'csv' then self.rouge_name = 'csvs'
    when 'html+erb' then self.rouge_name = 'erb'
    else
      self.rouge_name = downcased_name
    end
  end
end
