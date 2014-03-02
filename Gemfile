source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'crypt19', '1.2.1', git: 'git@github.com:coupa/crypt19.git'

gem 'foundation-rails'
gem 'active_model_otp'
gem 'rqrcode'
gem 'carrierwave'
gem 'carrierwave_securefile'

group :test, :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
