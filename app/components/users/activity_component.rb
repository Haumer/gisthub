class Users::ActivityComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
    @calendar = format_calendar
  end

  def format_calendar
    ((Date.today - 364.day)..Date.today).to_a.group_by do |day|
      day.cwday
    end.sort_by do |day|
      day.first
    end
  end

  private

  attr_reader :user, :calendar
end
