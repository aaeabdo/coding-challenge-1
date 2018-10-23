FROM ruby:2.5.1

MAINTAINER Ahmed Helil <ahmed.ahmed.abdelsattar.helil@gmail.com>

#
# apt-get update -qq
#
# apt-get update -> Update system packages list
# -qq            -> is added to produce output suitable for logging, omitting progress indicators.
# the double qq since we want the least amount of logs to be produced from that command.
#
# apt-get install -y --fix-missing --no-install-recommends build-essential libpq-dev
#
# apt-get install build-essential -> https://packages.debian.org/sid/build-essential,
# libpq-dev                       -> required for PostgreSQL
# -y                              -> Automatic yes to prompts.
# -m                              -> Ignore missing packages.
# --no-install-recommends         -> only the main dependencies (packages in the Depends field) are installed.
#
RUN apt-get update -qq && apt-get install -y -m --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client


ENV SERVICE_HOME /usr/local/src/service
RUN mkdir $SERVICE_HOME
WORKDIR $SERVICE_HOME

COPY Gemfile* $SERVICE_HOME/
RUN bundle install --jobs 4 --retry 3

COPY . $SERVICE_HOME

WORKDIR $SERVICE_HOME

ENTRYPOINT ["./bin/run_tests"]
