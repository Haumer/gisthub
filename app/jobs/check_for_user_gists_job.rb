class CheckForUserGistsJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    if args[:user_id]
      user = User.find(args[:user_id])
      Github::Gist::Client.new(user).save_gists
    else
      User.where(auto_import: true).each do |user|
        Github::Gist::Client.new(user).save_gists
      end
    end
  end
end
