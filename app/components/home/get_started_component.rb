class Home::GetStartedComponent < ViewComponent::Base
  def initialize(user_signed_in, current_user)
    @user_signed_in = user_signed_in
    @current_user = current_user
  end
end
