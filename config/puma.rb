# app_root = "#{app_root}/"
# pidfile "#{app_root}/tmp/pids/puma.pid"
# state_path "#{app_root}/tmp/pids/puma.state"
# stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true
# bind 'unix:/tmp/homeland.puma.sock'
daemonize false
port ENV.fetch("PORT") { 3000 }
workers 4
threads 8, 16
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

environment ENV.fetch("RAILS_ENV") { "development" }
#
# threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
# threads threads_count, threads_count

# # Specifies the `port` that Puma will listen on to receive requests, default is 3000.
# #
# port        ENV.fetch("PORT") { 3000 }

# # Specifies the `environment` that Puma will run in.
# #
# environment ENV.fetch("RAILS_ENV") { "development" }
