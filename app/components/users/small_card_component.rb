class Users::SmallCardComponent < ViewComponent::Base
  include ApplicationHelper
  def initialize(user:, rank:)
    @user = user
    @rank = rank
  end
end
