require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'active_support/all'

get '/' do
  erb :home
end

get '/new' do
  erb :new
end

get '/videos' do
  erb :videos
end

post '/create' do
  @title = params[:title]
  @description = params[:description]
  @url = params[:url]
  @category = params[:category]




end

def run_sql(sql)
  conn = PG.connect(:dbname =>'mytube', :host => 'localhost')
  result = conn.exec(sql)
  conn.close
  result
end