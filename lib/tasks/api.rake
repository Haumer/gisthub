namespace :api do
  namespace :gists do
    desc "Create and update gists"
    task :create_and_update_all => :environment do
      CheckForUserGistsJob.perform_later
    end

    desc "Create and update gists"
    task :create_and_update, [:user_id] => :environment do |t, args|
      CheckForUserGistsJob.perform_later(user_id: args[:user_id])
    end
  end
end
