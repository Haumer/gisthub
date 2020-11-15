class Users::ActivityComponent < ViewComponent::Base
  def initialize(user:, owner:)
    @user = user
    @owner = owner
    @calendar = format_calendar
    @user_gists = @user.user_gists
  end

  def format_calendar
    ((Date.today - 364.day)..Date.today).to_a.group_by do |day|
      day.cwday
    end.sort_by do |day|
      day.first
    end
  end

  def color_class(count)
    if count >= 1 && count <= 2
      "low-activity"
    elsif count >= 3 && count <= 5
      "medium-activity"
    elsif count >= 6
      "high-activity"
    else
      "no-activity"
    end
  end

  def gists_count(day)
    @user_gists.select { |ug| ug.date.to_date == day }.count
  end

  private

  attr_reader :user, :calendar, :owner
end
