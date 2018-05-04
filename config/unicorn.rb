# EC2 aws
# # set lets
# $worker = 2
# $timeout = 30
# $app_dir = "/home/ec2-user/cafeshares"
# $listen = File.expand_path 'tmp/sockets/.unicorn.sock', $app_dir
# $pid = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
# $std_log = File.expand_path 'log/unicorn.log', $app_dir
# # set config
# worker_processes $worker
# working_directory $app_dir
# stderr_path $std_log
# stdout_path $std_log
# timeout $timeout
# listen $listen
# pid $pid
# # loading booster
# preload_app true
# # before starting processes
# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
#   old_pid = "#{server.config[:pid]}.oldbin"
#   if old_pid != server.pid
#     begin
#       Process.kill "QUIT", File.read(old_pid).to_i
#     rescue Errno::ENOENT, Errno::ESRCH
#     end
#   end
# end
# # afeter finishing processes
# after_fork do |server, worker|
#   defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
# end

# centOS7
app_path = "/var/www/cafeshares"
working_directory "#{app_path}/current"
pid "#{app_path}/shared/tmp/pids/unicorn.pid"

listen "#{app_path}/shared/tmp/sockets/unicorn.sock"

stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

worker_processes 3

timeout 15

preload_app true

before_exec do |server|
  Dotenv.overload
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end