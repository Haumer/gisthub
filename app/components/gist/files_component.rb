class Gist::FilesComponent < ViewComponent::Base
  attr_reader :gist

  def initialize(gist:)
    @gist = gist
  end
end
