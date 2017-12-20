# Default to development environment
rails_env = ENV.fetch('RAILS_ENV') || 'development'

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

if rails_env == 'production'
  environment 'production'
  app_dir = File.expand_path("../..", __FILE__)
  bind "unix://#{app_dir}/tmp/puma.sock"
  pidfile "#{app_dir}/tmp/pids/puma.pid"
  workers ENV.fetch("WEB_CONCURRENCY") { 1 }
  daemonize true

  before_fork do
    ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
  end

  on_worker_boot do
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  end
else
  environment 'development'
  port ENV.fetch("PORT") { 3000 }
  plugin :tmp_restart
end
