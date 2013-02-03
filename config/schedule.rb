env :PATH, ENV['PATH']
set :output, "#{path}/log/cron.log"
set :job_template, "/bin/zsh -l -c -i ':job'"

job_type :runner,
  "cd :path && bin/rails runner -e :environment ':task' :output"
job_type :rake,
  "cd :path && RAILS_ENV=:environment bin/rake :task :output"

every 15.minutes do
  rake 'feeds:parse'
  #runner 'Feed.parse_all'
end
