FROM phusion/passenger-ruby25:0.9.35

MAINTAINER Ahmed Helil "ahmed.abdelsattar.helil@gmail.com"

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD ./server-config/nginx.conf /etc/nginx/sites-enabled/webapp.conf

# Pass environment variables from Nginx to Passenger.
# Since Nginx does not pass any environment variables to child processes.
COPY ./server-config/env-variables.conf /etc/nginx/main.d/service-env-variables.conf

# mount service
RUN mkdir /home/app/webapp
COPY --chown=app:app . /home/app/webapp

# Install gems
WORKDIR /home/app/webapp
RUN rvm-exec 2.5.1 gem install bundler
RUN rvm-exec 2.5.1 bundle install --jobs 4 --retry 3 --deployment --without development:test

# Add startup script to run during container startup
RUN mkdir -p /etc/my_init.d
ADD ./bin/setup_database.sh /etc/my_init.d/setup_database.sh
RUN chmod +x /etc/my_init.d/*.sh

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
