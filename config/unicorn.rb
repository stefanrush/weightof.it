root_path = "/home/ubuntu/weighof.it"

working_directory "#{root_path}/current"

pid "#{root_path}/shared/tmp/pids/unicorn.pid"

stderr_path "#{root_path}/shared/log/unicorn.error.log"
stdout_path "#{root_path}/shared/log/unicorn.access.log"

listen "#{root_path}/shared/tmp/sockets/unicorn.weighof.it.sock"

worker_processes 4

timeout 30