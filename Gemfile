source "https://rubygems.org"

ruby File.read(".ruby-version").strip

# Only include Rails frameworks we actually use (see config/application.rb)
gem "activemodel", "8.1.1"
gem "activejob", "8.1.1"
gem "activerecord", "8.1.1"
gem "actionpack", "8.1.1"
gem "actionmailer", "8.1.1"
gem "actionview", "8.1.1"
gem "railties", "8.1.1"
# Excluded: activestorage, actioncable, actiontext, actionmailbox

gem "pg"
gem "falcon"
gem "responders"
gem "simple_form"
gem "bootsnap", ">= 1.4.4", require: false
gem "csv"

# Asset related
gem "dartsass-rails"
gem "jsbundling-rails"
gem "sprockets-rails"

group :development, :test do
  gem "dotenv"
  gem "rspec-rails"
  gem "capybara"
  gem "capybara-email"
end

group :development do
  gem "listen"
end
