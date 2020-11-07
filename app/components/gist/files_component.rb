class Gist::FilesComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(gist:)
    @gist = gist
  end

  private

  attr_reader :gist
end
