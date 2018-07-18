set :application,     'freelancehub'
set :repo_url,        'git@github.com:softcomet/freelancerhub.git'
set :user,            'deploy'
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :assets_roles,    [:web, :app]
set :format,          :airbrussh
set :pty,             true
set :use_sudo,        false
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

set :rvm_ruby_version, "2.4.1@freelancehub"
set :rvm_type, :user

set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

# Bonus! Colors are pretty!
def red(str)
  "\e[31m#{str}\e[0m"
end

# Figure out the name of the current local branch
def current_git_branch
  branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
  puts "Deploying branch #{red branch}"
  branch
end

# Set the deploy branch to the current branch
set :branch, current_git_branch

namespace :assets do
  desc "compile assets locally and upload before finalize_update"
  task :deploy do
      %x[bundle exec rake assets:clean && bundle exec rake assets:precompile]
      ENV['COMMAND'] = " mkdir '#{release_path}/public/assets'"
      invoke
      upload '/#{app_dir}/public/assets', "#{release_path}/public/assets", {:recursive => true}
  end
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      #unless `git rev-parse HEAD` == `git rev-parse origin/master`
      #  puts "WARNING: HEAD is not the same as origin/master"
      #  puts "Run `git push` to sync changes."
      #  exit
      #end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

desc "Run rake db:seed on a remote server."
task :seed do
  on roles (:app) do
    within release_path do
      with rails_env: fetch(:rails_env) do
        execute :rake, "db:seed"
      end
    end
  end
end