class Gist::FilesComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(gist:)
    @gist = gist
  end

  def language?(file)
    file.language.present?
  end

  private

  attr_reader :gist
end
