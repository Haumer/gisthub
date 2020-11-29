module ApplicationHelper
  def controller_is_users_show?(params)
    params[:controller] == "users" && params[:action] == "show"
  end

  def user_rank(rank)
    case rank
    when 1 then "gold"
    when 2 then "silver"
    when 3 then "bronze"
    end
  end

  def active?(path, controller)
    # FIXME (haumer): rework
    "active" if controller == path
  end

  def rouge(text, language)
    formatter = Rouge::Formatters::HTML.new
    formatter = Rouge::Formatters::HTMLLineTable.new(formatter, opts={})
    lexer = Rouge::Lexer.find(language)
    lexer ? formatter.format(lexer.lex(text)) : text
  end

  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks]
    Markdown.new(text, *options).to_html.html_safe
  end
end
