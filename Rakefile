# Rakefile
require 'sinatra/activerecord/rake'

ENV['DISABLE_DATABASE_ENVIRONMENT_CHECK'] = 'test'

namespace :db do
  task :load_config do
    require './service'
  end

  desc "create a database if not existing"
  task create_if_not_existing: [:environment, :load_config] do
    begin
      ActiveRecord::Base.connection
    rescue ActiveRecord::NoDatabaseError
      Rake::Task['db:create'].invoke
    end
  end
end

desc 'runs console'
task :console, :environment do |_t, args|
  exec 'irb -r irb/completion -r ./service.rb'
end

task c: :console

Dir['./lib/**/*.rake'].sort.each { |file| import file }
