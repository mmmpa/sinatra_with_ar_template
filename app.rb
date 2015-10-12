require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'sinatra/reloader' if development?
require 'active_support'
require 'slim'
require 'pp'

Dir["#{__dir__}/initializers/**/*.rb"].each(&method(:require))
Dir["#{__dir__}/app/**/*.rb"].each(&method(:require))

set :views, "#{__dir__}/app/views/"
enable :sessions

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  slim :index
end

private

def symbolize_params
  @normalized ||= params.deep_symbolize_keys!
end
