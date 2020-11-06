class Gist::FilesComponent < ViewComponent::Base
  require 'rouge'

  def initialize(gist:)
    @gist = gist
  end

  def highlighter(code)
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
    lexer = Rouge::Lexer.find('ruby')
    formatter.format(lexer.lex(code))
  end

  attr_reader :gist
end
