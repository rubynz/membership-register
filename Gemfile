source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "rails", "7.1.3.4"
gem "pg"
gem "falcon"
gem "responders"
gem "simple_form"
gem "bootsnap", ">= 1.4.4", require: false

# Asset related
gem "sass-rails", ">= 6"
gem "sprockets", "< 4"
gem "jsbundling-rails"

group :development, :test do
  gem "dotenv"
  gem "rspec-rails"
  gem "capybara"
  gem "capybara-email"
end

group :development do
  gem "listen"
end
