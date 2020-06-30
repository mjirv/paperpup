namespace :sources do
  desc "Refreshes existing sources in the database"
  task refresh: :environment do
    Source.refresh_all_sources()
  end

end
