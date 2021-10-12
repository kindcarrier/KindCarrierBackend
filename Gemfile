source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'active_model_serializers'
gem 'pg'
gem 'rails', '~> 5.2.2'
# Use Puma as the app server
gem 'puma', '~> 5.5'
# Use SCSS for stylesheets
gem 'carrierwave', '~> 1.0'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

gem 'active_interaction'
gem 'activerecord-postgis-adapter'
gem 'dotenv-rails'
gem 'mini_magick'
gem 'pundit'
gem 'rack-cors'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sorcery'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'factory_bot_rails'
gem 'ffaker'
gem 'kaminari'

group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-instafail', require: false
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'rubocop', '~> 0.61.1', require: false
  gem 'sqlite3', '~> 1.3.6'
  gem 'travis'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
