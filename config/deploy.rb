require 'bundler/capistrano'

options[:pty] = true

set :application, 'tvshows'
set :repository,  "/Users/Saxon/Repositories/#{application}.git"
set :local_repository,  "unrue.com:/Users/Saxon/Repositories/#{application}.git"

set :bundle_flags, "--deployment --quiet --binstubs"
#set (:bundle_cmd) { "#{release_path}/bin/bundle" }

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :scm, :git

set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :deploy_to, "/Users/Saxon/Sites/#{application}"
set :deploy_via, :remote_cache

role :web, 'unrue.com'                   # Your HTTP server, Apache/etc
role :app, 'unrue.com'                   # This may be the same as your `Web` server
role :db,  'unrue.com', :primary => true # This is where Rails migrations will run
role :db,  'unrue.com'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_config do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

after 'deploy:finalize_update', 'deploy:symlink_uploads'
after 'deploy:finalize_update', 'deploy:symlink_config'
