lock '3.4.0'

set :application, 'weightof.it'
set :repo_url, 'git@github.com:stefanrush/weightof.it'
set :branch, 'development'
set :deploy_to, '/home/ubuntu/weightof.it'
set :linked_files, fetch(:linked_files, []).push('config/application.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :passenger_restart_with_sudo, true

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'passenger:restart'
    end
  end

  after :publishing, :restart
end

namespace :clockwork do
  desc "Start clockwork"
  task :start do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c lib/clockwork.rb --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} start"
        end
      end
    end
  end

  desc "Stop clockwork"
  task :stop do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c lib/clockwork.rb --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} stop"
        end
      end
    end
  end

  desc "Restart clockwork"
  task :restart do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c lib/clockwork.rb --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} restart"
        end
      end
    end
  end

  desc "Check clockwork status"
  task :status do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :clockworkd, "-c lib/clockwork.rb --pid-dir=#{cw_pid_dir} --log-dir=#{cw_log_dir} status"
        end
      end
    end
  end

  def cw_log_dir
    "#{shared_path}/log"
  end

  def cw_pid_dir
    "#{shared_path}/tmp/pids"
  end

  def rails_env
    fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
  end
end
