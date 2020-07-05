class Gist::CardComponent < ViewComponent::Base
  def initialize(gist)
    @gist = gist
    @edit_url = Github::Gists::Api.new(@gist.user).edit_gist_url(@gist)
  end
end
