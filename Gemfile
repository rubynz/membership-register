source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem "rails", "6.1.4.7"
gem "pg"
gem "puma"
gem 'responders'
gem 'simple_form'
gem "bootsnap", ">= 1.4.4", require: false

# Asset related
gem 'sass-rails', '>= 6'
gem "sprockets", "< 4"
gem 'webpacker', '~> 5.0'

group :development, :test do
  # Load local .env files
  gem 'dotenv-rails'

  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-email'
end

group :development do
  gem "listen"
end
