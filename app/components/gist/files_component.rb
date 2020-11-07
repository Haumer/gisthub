class Gist::FilesComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(gist:)
    @gist = gist
  end

  private

  def language(name)

  end

  attr_reader :gist
end
