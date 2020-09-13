class Gist::CardComponent < ViewComponent::Base
  include ApplicationHelper
  def initialize(gist:, user:, full:)
    @gist = gist
    @edit_url = Github::Gists::Api.new(@gist.user).edit_gist_url(@gist)
    @gist_url = Github::Gists::Api.new(@gist.user).gist_url(@gist)
    @user = user
    @full = full
  end

  def permitted?
    @gist.user == @user
  end

  def render?
    @gist.gist_files.map(&:size).sum < 10000
  end
end
