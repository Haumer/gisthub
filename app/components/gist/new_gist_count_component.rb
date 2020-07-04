class Gist::NewGistCountComponent < ViewComponent::Base
  def initialize(count, user)
    @count = count.to_i
    @user = user
  end

  def render?
    @count != 0
  end
end
