# Some notes about the steps I took to deploy to production.

### Host
* Using a nano instance on Amazon EC2. Amazon AMI Linux is the OS.

### HTTP servers
* NGINX is the HTTP server running a reverse proxy.
* Added an include at the bottom of the nginx.conf file: `include /etc/nginx/sites/*;`, and created a `sites` directory in `/etc/nginx`

```
# /etc/nginx/sites/grades2.conf
upstream app {
    # Path to Puma SOCK file, as defined previously
    server unix:/home/ec2-user/grades2/tmp/puma/puma.sock fail_timeout=0;
}

server {
    listen 80;
    server_name grades.website.com www.grades.website.com;

    root /home/ec2-user/grades2/public;

    location @app {
        proxy_pass http://app;
        proxy_redirect off;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location / {
      try_files $uri @app;
    }

    location ^~ /packs/ {
        gzip_static on;
        expires max;
        add_header Cache-Control public;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}
```

### Application server
* puma is the application server. The config/puma.rb file has been modified to support development and production modes.
* Need to `mkdir -p tmp/puma/pids` to ensure the directories are present for puma.rb.

```
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
  daemonize true

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
```

* Created my own upstart script because the "Jungle Upstart" scripts that puma provides would not work for me.

```
description "puma-grades2"

# This starts upon bootup and stops on shutdown
start on runlevel [2345]
stop on runlevel [06]

# So much hack, but so much working.
# Default puma-manager scripts don't work well. :(
exec sudo su -c 'cd /home/ec2-user/grades2; source "/home/ec2-user/.rvm/scripts/rvm"; export RAILS_ENV=production; puma -C config/puma.rb -e production' ec2-user
```

### File permissions
* `chmod 755 /home/ec2-user` was needed to allow NGINX to read the assets and the puma.sock file.

### Ruby
* Using RVM to manage ruby. Followed standard directions.
* Created a `ruby-2.4.3@grades2` gemset.

### Database
* Using PostgreSQL for the database server. Followed standard directions.
* `sudo su - postgres` then `psql` to get into the console.
* `show hba_file;` to show config file. Edit file and change local/all/all to 'trust', not 'peer'
* Had to create a role for the app: `create role grades2 with createdb login password 'password';`
* Getting the pg gem to install on Amazon Linux: https://stackoverflow.com/a/41049917
