namespace :sources do
  desc "Refreshes existing sources in the database"
  task refresh: :environment do
    Source.refresh_all_sources()
  end

  task create_from_defaults: :environment do
    def create_source(row, rss_type)
      Source.create!(source: row[0], title: row[1], color: row[3], rss_type: rss_type)
    end

    default_sources = CSV.read('lib/default_sources.csv')
    default_sources.each do |row|
      if not row.blank? and not row[0].nil?
        begin
          create_source(row, 'rss') rescue create_source(row, 'atom')
        rescue Exception => e
          puts "#{e}, #{row[0]}"
        end
      end
    end
  end
end
