#!/bin/sh

bin/rake db:create_if_not_existing
bin/rake db:migrate
