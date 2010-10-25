namespace :updater do
  
  task :update => :environment do
    Site.find_each do |s|
      puts "Updating #{s.name}"
      s.update_feed!
    end
  end
  
  task :repeated_update => :environment do
    loop do
      Site.find_each { |s| puts "Updating #{s.name}"; s.update_feed! }
      sleep 10
    end
  end
  
end