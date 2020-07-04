class Gist::NewGistCountComponent < ViewComponent::Base
  def initialize(count)
    @count = count.to_i
  end

  def render?
    @count != 0
  end
end
