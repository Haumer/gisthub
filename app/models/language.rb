class Language < ApplicationRecord
  has_many :gist_file_languages, dependent: :destroy
  has_many :gist_files, through: :gist_file_languages
  before_create :set_rouge_name

  def set_rouge_name
    downcased_name = name.downcase

    case downcased_name
    when 'csv' then self.rouge_name = 'csvs'
    when 'html+erb' then self.rouge_name = 'erb'
    when 'jupyter notebook' then self.rouge_name = 'markdown'
    else
      self.rouge_name = downcased_name
    end
  end

  def lines
    gist_files.map(&:size).sum
  end
end
