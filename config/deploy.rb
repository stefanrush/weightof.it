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
