class Gist::CardComponent < ViewComponent::Base
  include ApplicationHelper
  include Devise
  def initialize(gist:, user:, full:, modal:, permitted:)
    @gist = gist
    @edit_url = Github::Gists::Api.new(@gist.user).edit_gist_url(@gist)
    @gist_url = Github::Gists::Api.new(@gist.user).gist_url(@gist)
    @user = user
    @full = full
    @modal = modal
    @permitted = permitted
  end

  def permitted?
    @permitted
  end

  def render?
    @gist.gist_files.map(&:size).sum < 10000
  end
end
