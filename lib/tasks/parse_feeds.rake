namespace :feeds do
  desc 'Checks feeds for new files'
  task :parse => :environment do
    Feed.parse_all
  end
end
