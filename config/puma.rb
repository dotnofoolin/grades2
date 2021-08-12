# Default to development environment
rails_env = ENV.fetch('RAILS_ENV', 'development')

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

if rails_env == 'production'
  puts 'Starting in production mode...'
  environment 'production'
  app_dir = File.expand_path("../..", __FILE__)
  stdout_redirect "#{app_dir}/log/puma.log", "#{app_dir}/log/puma.log", true
  bind "unix://#{app_dir}/tmp/puma/puma.sock?umask=0111"
  pidfile "#{app_dir}/tmp/puma/pids/puma.pid"
  state_path "#{app_dir}/tmp/puma/state"
  activate_control_app

  workers ENV.fetch("WEB_CONCURRENCY") { 1 }

  before_fork do
    ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
  end

  on_worker_boot do
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  end
else
  puts 'Starting in development mode...'
  environment 'development'
  port ENV.fetch("PORT") { 3000 }
  plugin :tmp_restart
end
