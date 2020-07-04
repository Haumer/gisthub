class Gist::NewGistCountComponent < ViewComponent::Base
  def initialize(count, user)
    @count = count
    @user = user
  end

  def render?
    @count != 0
  end
end
