# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.5.1'

gem 'activerecord',         '~> 5.2.1'  # ORM
gem 'json-schema',          '~> 2.8.1'  # validate request against schemas
gem 'passenger',            '~> 5.3.5'
gem 'pg',                   '~> 1.1.3'  # postgres database
gem 'rack-protection',      '~> 2.0.4'  # A set of middlware that can be added to the resource to protect it against typical web attacks
gem 'rake',                 '~> 12.3.1' # task management
gem 'sinatra',              '~> 2.0.4'  # DSL
gem 'sinatra-activerecord', '~> 2.0.13' # let activerecord play nicely with sinatra
gem 'sinatra-contrib',      '~> 2.0.1'  # Sinatra Extensions
gem 'httpi',                '~> 2.4.4'  # Common interface for Ruby's HTTP clients
gem 'treetop-dcf',          '~> 0.2.1'
gem 'whenever',             '~> 0.10.0', require: false

group :development, :test do
  gem 'memory_profiler', '~> 0.9.12', require: false
  gem 'pry-byebug',      '~> 3.6.0'                  # debugging
  gem 'reek',            '~> 5.2.0',  require: false # code smell
  gem 'rubocop',         '~> 0.59.2', require: false # coding style enforcment
  gem 'rubocop-rspec',   '~> 1.30.0', require: false # coding style enforcment
  gem 'dotenv',          '~> 2.5.0'                  # A Ruby gem to load environment variables from `.env`.
end

group :development do
  gem 'yard', '~> 0.9.16', require: false # YARD is a Ruby Documentation tool.
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'factory_bot',      '~> 4.11.1'
  gem 'rack-test',        '~> 1.1.0'
  gem 'rspec',            '~> 3.8.0'
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'simplecov',        '~> 0.16.1', require: false
end
