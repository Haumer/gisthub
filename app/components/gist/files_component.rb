class Gist::FilesComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(gist:, full:)
    @gist = gist
    @full = full
  end

  def language?(file)
    file.language.present?
  end

  private

  attr_reader :gist, :full
end
