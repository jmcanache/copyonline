source 'https://rubygems.org'
ruby '2.2.2'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'coffee-script-source', '~> 1.8.0'

gem 'slim-rails'

gem 'jquery-rails'

gem 'jquery-turbolinks'

# Gema para gestion de permisos
gem "cancan"
gem "rails_12factor"
gem 'seed_migration'
# Use jquery as the JavaScript library
#gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'

gem 'devise-i18n'

gem 'rails-i18n', '~> 4.0', '>= 4.0.7'

gem 'paperclip', '~> 3.5.3'

gem 'paperclip-dropbox', '~> 1.3.2'

gem 'will_paginate', '~> 3.0'

gem "font-awesome-rails"

gem 'bootstrap-combobox', '~> 1.2', '>= 1.2.6'

gem 'bootstrap-will_paginate'

#gem 'mysql2', '~> 0.3.18'

gem 'pg', '~> 0.18.4'

gem 'sprockets-rails', :require => 'sprockets/railtie'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'pry'
  #gem 'pry-byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end
group :production do
  gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
