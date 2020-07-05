class GistFiles::FileComponent < ViewComponent::Base
  def initialize(gist)
    @gist = gist
    @user = gist.user
  end

  def render?
    @gist.present?
  end
end
