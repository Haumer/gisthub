class Gist::CardComponent < ViewComponent::Base
  def initialize(gist)
    @gist = gist
  end
end
