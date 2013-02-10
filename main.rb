require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'active_support/all'

before do
  sql = "select category, count(category) as count from videos group by category order by category;"
  @nav_rows = run_sql(sql)
end

get '/' do
  erb :home
end

get '/videos/:category' do
  @category = params[:category]
  sql = "select * from videos where category = '#{@category}';"
  @rows = run_sql(sql)
  erb :videos
end

get '/new' do
  erb :new
end

get '/about' do
  erb :about
end

get '/videos' do
  sql = "select * from videos;"
  @rows = run_sql(sql)
  erb :videos
end

post '/create' do
  @name = params[:name].gsub("'","")
  @description = params[:description].gsub("'","")
  @url = params[:url].match(/(http:\/\/[a-z\.\/A-Za-z0-9_-]+)/)[1]
  @category = params[:category].gsub("'","")

  sql = "insert into videos (name, description, url, category) values ('#{@name}','#{@description}','#{@url}','#{@category}');"
  run_sql(sql)
  redirect to('/videos')
end

post '/videos/:video_id/delete' do
  @video_id = params[:video_id]
  sql = "delete from videos where id = #{@video_id};"
  run_sql(sql)
  redirect to('/videos')
end

get '/videos/:video_id/edit' do
  @video_id = params[:video_id]
  sql = "select * from videos where id = #{@video_id};"
  rows = run_sql(sql)
  @row = rows.first
  erb :new

end

post '/videos/:video_id' do
  @video_id = params[:video_id]
  @name = params[:name].gsub("'","")
  @description = params[:description].gsub("'","")
  @category = params[:category].gsub("'","")

  sql = "update videos set name = '#{@name}', description = '#{@description}', category = '#{@category}' where id = #{@video_id};"
  run_sql(sql)
  redirect to('/videos')
end


def run_sql(sql)
  conn = PG.connect(:dbname =>'mytube', :host => 'localhost')
  result = conn.exec(sql)
  conn.close
  result
end