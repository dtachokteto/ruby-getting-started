require 'sinatra'
require 'sinatra/reloader'
require 'debug'

set :bind, '0.0.0.0'

get '/' do
  message = 'Hello world!'
  message
end
