source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

# Fix ambiguous gems
gem 'minitest', '5.16.3'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]

  # FactoryBot integration between FactoryBot and Rails
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'

  # RSpec is a testing tool for Ruby, created for behavior-driven development (BDD)
  gem 'rspec-rails', '~> 6.1', '>= 6.1.3'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'

  # Automatic Ruby code style checking tool
  gem 'rubocop', '~> 1.65', require: false

  # IDE tools for code completion, inline documentation, and static analysis
  gem 'solargraph', '~> 0.50.0', require: false

  # Helps us to format ERB files, so our eyes don't bleed :)
  gem 'htmlbeautifier', '~> 1.4', '>= 1.4.3', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'

  # Cuprite is a modern Capybara driver which uses Chrome CDP API
  gem 'cuprite', '~> 0.15.1'

  # Ruby applications tests profiling tools
  gem 'test-prof', '~> 1.3', '>= 1.3.3.1'

  # Webmock is a library for stubbing http request (with Faraday in the case)
  gem 'webmock', '~> 3.23', '>= 3.23.1'

  # Provides RSpec- and Minitest-compatible one-liners to test common Rails
  # functionality that, if written by hand, would be much longer, more complex,
  # and error-prone.
  gem 'shoulda-matchers', '~> 6.2'

  # Generates test vs. code coverage reports
  gem 'simplecov', '~> 0.22.0', require: false
end

# Use Vite in Rails
gem 'vite_rails', '~> 3.0', '>= 3.0.17'
