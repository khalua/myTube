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
  sql = "select * from videos;"
  @rows = run_sql(sql)
  erb :videos
end

post '/create' do
  @title = params[:title].gsub("'","")
  @description = params[:description].gsub("'","")
  @url = params[:url]
  @category = params[:category].gsub("'","")

  sql = "insert into videos (title, description, url, category, timestamp) values ('#{@title}','#{@description}','#{@url}','#{@category}',now());"

  run_sql(sql)

  redirect to('/videos')

end

def run_sql(sql)
  conn = PG.connect(:dbname =>'mytube', :host => 'localhost')
  result = conn.exec(sql)
  conn.close
  result
end