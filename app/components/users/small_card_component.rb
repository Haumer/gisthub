class Users::SmallCardComponent < ViewComponent::Base
  include ApplicationHelper
  def initialize(user:, rank:, count:)
    @user = user
    @rank = rank
    @count = count
  end
end
