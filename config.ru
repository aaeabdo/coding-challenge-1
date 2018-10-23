require 'rubygems'
require 'sinatra'
require File.expand_path 'service.rb', __dir__

map('/')    { run BaseResource }
map('/v1/') { run V1 }
