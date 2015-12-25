require 'bundler/capistrano'
require 'rvm/capistrano' 

set :application, "orden"
set :user, "ubuntu"
ssh_options[:keys] = ['~/.ssh/xdm.pem']

set :port, 22
set :deploy_to, "/home/sites/#{application}"
set :deploy_via, :remote_cache
set :copy_exclude, [".git/*", ".tmp/*"]
set :use_sudo, false

set :repository,  'git@bitbucket.org:iSunRise/orden-site.git'

set :scm, :git
set :branch, "master"

set :keep_releases, 2
default_run_options[:pty] = true

server "xdm.me", :app, :web, :db, :primary => true

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
before 'deploy:assets:precompile', 'deploy:symlink_config'

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  desc "Symlink config"
  task :symlink_config do 
    run "rm -rf #{latest_release}/config/database.yml && ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
  end
  after "deploy:setup", "deploy:setup_config"
end

