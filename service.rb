require 'erb'

SERVICE_NAME = 'service'
ENVIRONMENT  ||= ENV['SINATRA_ENV'] || ENV['RACK_ENV'] || 'development'
# reset all enviroment to be the fetched one
ENV['SINATRA_ENV'] = ENV['RACK_ENV'] = ENVIRONMENT

if %w(development test).include?(ENVIRONMENT)
  require 'dotenv/load'
end

APP_ROOT = File.expand_path(__dir__)

require 'sinatra/activerecord'
require 'json-schema'

[
  './config/initializers/*.rb',
  './models/*.rb',
  './lib/**/*.rb',
  './resources/**/*.rb'
].each do |dir|
  Dir[dir].sort.each { |file| require file }
end
