class ImportForGroupJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    Github::Gist::Client.new(
      User.find(user_id)
    ).save_gists
  end
end
