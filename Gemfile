source 'https://rubygems.org'

gem 'rails', '3.2.11'

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
  gem "factory_girl"
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

gem "jquery-rails"
gem "rspec-rails", ">= 2.0.1", :group => [:development, :test]
gem "capybara", :group => [:development, :test]