source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'scoped_search', '~> 2.4.0'
gem 'RedCloth', '~> 4.2.9'
gem 'dynamic_form', '~> 1.1.4'
gem 'jquery-rails', '~> 2.2.1'
gem 'thin', '~> 1.5.0'

group :production do
  gem 'pg', '~> 0.14.1'
end

group :test do
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'coveralls', require: false
end

group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'

  gem 'uglifier', '>= 1.3.0'
end

