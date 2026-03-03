namespace :sync do
  desc "Sync items and influencers from Description Reader"
  task from_description_reader: :environment do
    DescriptionReaderClient.sync
    puts "Sync complete"
  end
end
