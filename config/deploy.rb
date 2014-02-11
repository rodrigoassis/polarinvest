require "bundler/capistrano"
require "rvm/capistrano"

server "162.243.70.102", :web, :app, :db, primary: true

set :application, "polarinvest"
set :user, "polaris"
set :port, 22
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :copy
set :use_sudo, true
set :rvm_ruby_string, "ruby-2.1.0-p0"

set :scm, "git"
set :repository, "git@github.com:rodrigoassis/polarinvest.git"
set :branch, "develop"
set :rvm_type, :system

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/develop`
      puts "WARNING: HEAD is not the same as origin/develop"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  task :precompile_assets do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end

  task :update_sitemap do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake sitemap:refresh"
  end

  task :nginx_restart do
    run "cd #{release_path} && #{try_sudo} service nginx restart"
  end

  before "deploy", "deploy:check_revision"
  after 'deploy:update_code', 'deploy:precompile_assets', 'deploy:update_sitemap', 'deploy:nginx_restart'

end
