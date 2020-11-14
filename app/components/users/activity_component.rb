class Users::ActivityComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
    @calendar = ((Date.today- 1.year)..Date.today).to_a.freeze
  end

  private

  attr_reader :user, :calendar
end
