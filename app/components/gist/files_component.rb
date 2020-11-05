class Gist::FilesComponent < ViewComponent::Base
  def initialize(gist:)
    @gist = gist
  end

  attr_reader :gist
end
