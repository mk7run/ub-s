# RESTFUL Routing:
# display all things
get '/things' do
  erb :"/things/index"
end

# render a new thing form
get '/things/new' do
  authenticate!
  erb :"/things/new"
end

# create a new thing
post '/things' do
  authenticate!
  redirect '/things'
end

# display a specific thing
get '/things/:id' do
  erb :"/things/show"
end

# render an edit form for a thing
get '/things/:id/edit' do
  authenticate!
  authorized!
  erb :"/things/:id/edit"
end

# update a thing
put '/things/:id' do
  authenticate!
  authorized!
  redirect "/things/#{params[:id]}"
end

# delete a specific thing
delete '/things/:id' do
  authenticate!
  authorized!
  redirect '/things'
end


