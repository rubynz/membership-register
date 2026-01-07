source "https://rubygems.org"

ruby File.read(".ruby-version").strip

# Only include Rails frameworks we actually use (see config/application.rb)
rails_version = "8.1.1"
gem "activemodel", rails_version
gem "activejob", rails_version
gem "activerecord", rails_version
gem "actionpack", rails_version
gem "actionmailer", rails_version
gem "actionview", rails_version
gem "railties", rails_version
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
