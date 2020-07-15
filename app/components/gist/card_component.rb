class Gist::CardComponent < ViewComponent::Base
  include ApplicationHelper
  def initialize(gist:, user:)
    @gist = gist
    @edit_url = Github::Gists::Api.new(@gist.user).edit_gist_url(@gist)
    @gist_url = Github::Gists::Api.new(@gist.user).gist_url(@gist)
    @user = user
  end

  def permitted?
    @gist.user == @user
  end
end
