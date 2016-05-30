require 'sinatra'
require 'bundler'
Bundler.require :default

# Main app class
class App < Sinatra::Base
  set :environment, :development
  set :session, false
  set :method_override, true
  set :root, File.dirname(__FILE__)
  set :run, false
  set :bind, '0.0.0.0'
  set :port, 3000
  set :server, :puma

  get '/' do
    send_file 'index.html'
  end

  post '/' do
    response = HTTParty.get('http://programmingexcuses.com/')
      pattern = %r(\<a href="\/" rel="nofollow".*?\>(.*?)\<)
      content = pattern.match(response.body)[1]
      json response_type: 'in_channel',
           text: content
  end

  run! if app_file == $PROGRAM_NAME
end
