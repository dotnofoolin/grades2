source 'https://rubygems.org'

gem 'rails', '~> 6.0.0'
gem 'pg', '~> 0.18'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'webpacker'
# gem 'redis', '~> 3.0'
gem 'hac_adapter', '1.1.0', git: 'https://github.com/dotnofoolin/hac_adapter.git'
gem 'rufus-scheduler'

group :test do
  gem 'rspec-rails', '~> 4.0.0.beta2' # TODO: come back and remove the version lock. See: https://github.com/rails/rails/issues/35417
  gem 'webmock'
  gem 'vcr'
  gem 'simplecov'
  gem 'fabrication'
  gem 'faker'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
