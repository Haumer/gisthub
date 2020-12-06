class Gist::CardComponent < ViewComponent::Base
  include ApplicationHelper

  with_collection_parameter :gist

  def initialize(gist:, user:, full:, modal:, permitted:)
    @gist = gist
    @user = user
    @full = full
    @modal = modal
    @permitted = permitted
    @current_user = current_user || nil
  end

  def permitted?
    @permitted
  end

  def render?
    @gist.gist_files.map(&:size).sum < 10000
  end

  private

  attr_reader :full, :modal, :user, :current_user
end
