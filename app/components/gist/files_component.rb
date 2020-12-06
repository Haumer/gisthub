class Gist::FilesComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(gist:, full:, current_user:)
    @gist = gist
    @full = full
    @current_user = current_user
  end

  def language?(file)
    file.language.present?
  end

  private

  attr_reader :gist, :full, :current_user
end
