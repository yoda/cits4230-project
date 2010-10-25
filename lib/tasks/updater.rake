namespace :updater do
  
  task :update => :environment do
    Site.find_each { |s| s.update_feed! }
  end
  
  task :repeated_update => :environment do
    loop do
      Site.find_each { |s| s.update_feed! }
      sleep 10
    end
  end
  
end