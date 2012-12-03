namespace :feeds do
  desc 'Checks feeds for new files'
  task :parse => :environment do
    Feed.parse_all
    puts "Feed has been parsed - #{Time.now}"
  end
end
