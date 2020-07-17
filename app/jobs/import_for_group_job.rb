class ImportForGroupJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    Github::Gists::Api.new(
      User.find(user_id)
    ).save_gists
  end
end
