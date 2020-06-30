source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'pg'
gem 'httparty'
gem 'nokogiri'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-highlight'
  gem 'pry-stack_explorer'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'database_cleaner-sequel'
end

group :production do
  # gem 'puma'
end
