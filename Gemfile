source 'https://rubygems.org'

#for more robust error logging on heroku
gem 'rails_12factor'

#use dotenv to load environment file
#this way you can use "rails s" instaed of "heroku local" and get all your .env vars and still use the debugger, etc.
gem 'dotenv-rails', :groups => [:development, :test]

#authentication
gem "omniauth-google-oauth2"

#for easy enum dropdowns
gem 'enum_help'

#for easy sorting & searching
gem 'ransack'

gem 'puma'
gem "slim-rails"

#money!
gem "money-rails"


#for GOV.UK template
gem 'govuk_template'
#gem 'slimmer'

#for other GOV.UK elements
gem 'govuk_elements_rails'

#for sass mixins
gem 'govuk_frontend_toolkit'


#pagination
#gem "kaminari"
gem 'kaminari-bootstrap', '~> 3.0.1'

#bootstrap-generators
gem 'bootstrap-generators', '~> 3.3.4'

#for pretty select boxes
# use class="selectpicker"
gem 'bootstrap-select-rails'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do

  #cucumber stuff, for now, only doing this in development
  gem 'cucumber' #our testing framework
  gem 'capybara' #nice DSL for talking to the browser in code.
  gem 'selenium-webdriver' #usual, firefox driver
  gem 'phantomjs'
  gem 'poltergeist' #headless driver
  gem 'rspec' #gives us a few nice methods like "page.should"
  gem 'pry' # for command line debugging
  gem 'capybara-screenshot'
  gem 'firefox'
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
