class Gist::FilesComponent < ViewComponent::Base
  require 'rouge'

  def initialize(gist:)
    @gist = gist
  end

  def highlighter(code)
    formatter = Rouge::Formatters::HTML.new("github")
    lexer = Rouge::Lexers::Ruby.new
    formatter.format(lexer.lex(code)).html_safe
  end

  attr_reader :gist
end
