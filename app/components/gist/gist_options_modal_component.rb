class Gist::GistOptionsModalComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(user:, gist:, edit_url:, permitted:)
    @gist = gist
    @user = user
    @edit_url = edit_url
    @permitted = permitted
  end

  def permitted?
    @permitted
  end
end
