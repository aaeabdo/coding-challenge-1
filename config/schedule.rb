base_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))

job_type :rake, "cd #{base_dir} && bin/rake :task SINATRA_ENV=production"

every 1.day, at: '12:00 am' do
  rake "general:import_packages "\
       "-- -s 'http://cran.r-project.org/src/contrib/' "\
       "-p 'PACKAGES' "\
       "-t '{server_dir}{package_name}_{package_version}.tar.gz' "\
       "-d 'DESCRIPTION' -l 5"
end
