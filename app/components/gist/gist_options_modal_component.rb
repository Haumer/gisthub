class Gist::GistOptionsModalComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(user:, gist:, permitted:)
    @gist = gist
    @user = user
    @permitted = permitted
  end

  def permitted?
    @permitted
  end
end
