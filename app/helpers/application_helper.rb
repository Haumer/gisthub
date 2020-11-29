module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

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

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
      render_options = {
        hard_wrap: true,
        link_attributes: { rel: 'nofollow' },
        prettify: true
      }
      renderer = HTML.new(render_options)
      options = {
        autolink: true,
        no_intra_emphasis: true,
        disable_indented_code_blocks: true,
        fenced_code_blocks: true,
        strikethrough: true,
        superscript: true,
        lax_spacing: true
      }

    markdown = Redcarpet::Markdown.new(renderer, options)
    raw markdown.render(text)
  end
end
