require 'sinatra/activerecord'
require_relative '../representers/errors'

class BaseResource < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :root, File.dirname(File.dirname(__FILE__))
  set :raise_errors, true
  set :show_exceptions, false
  before { content_type :json }

  get '/health_check' do
    begin
      {
        service_name:  SERVICE_NAME,
        database_name: database.connection.current_database,
        environment:   ENVIRONMENT
      }.to_json
    rescue StandardError
      status 500

      Representers::Errors.error_body(500, 'Database Not running').to_json
    end
  end

  not_found do
    # Replace sinatra default not found
    if response.body.join == "<h1>Not Found</h1>"
      Representers::Errors.error_body(404, 'Not Found').to_json
    end
  end
end
