source 'https://rubygems.org'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem 'puma'
gem 'sass-rails'
gem 'sassc', '2.1.0' # Don't install 2.4.0 or newer. Stupid slow compile/install times. Revisit this later. See: https://github.com/sass/sassc-ruby/issues/189
gem 'uglifier'
gem 'webpacker'
gem 'hac_adapter', '1.3.0', git: 'https://github.com/dotnofoolin/hac_adapter.git'
gem 'rufus-scheduler'
gem 'dotenv-rails'

group :test do
  gem 'rspec-rails'
  gem 'webmock'
  gem 'vcr'
  gem 'simplecov'
  gem 'fabrication'
  gem 'faker'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
