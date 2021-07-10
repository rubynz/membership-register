source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'rails', '~> 5.2.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'responders'
gem 'simple_form'
gem 'rack-canonical-host'
gem 'bootsnap'

# Asset related
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass', '~> 3.4.1'

group :development, :test do
  gem "rspec-rails"
end

group :development do
  gem 'listen', '~> 3.0.5'
end

group :test do
  gem "capybara"
end

gem "mimemagic", git: "https://github.com/minad/mimemagic.git", ref: "01f92d86d15d85cfd0f20dabd025dcbd36a8a60f"
