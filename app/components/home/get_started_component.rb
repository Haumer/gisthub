class Home::GetStartedComponent < ViewComponent::Base
  def initialize(user_signed_in:, user:)
    @user_signed_in = user_signed_in
    @user = user
  end
end
