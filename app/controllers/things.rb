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
  @thing = Thing.new(params[:thing])
  authenticate!
  
  if @thing.valid?
    current_user.things << @things
    redirect "/things/#{@thing.id}"
  else
    @errors = @things.errors.full_messages
    erb :"/things/new"
  end
end

# display a specific thing
get '/things/:id' do
  @thing = find_and_ensure(params[:id])
  erb :"/things/show"
end

# render an edit form for a thing
get '/things/:id/edit' do
  @thing = find_and_ensure(params[:id])
  authenticate!
  authorize!(@thing.owner)
  erb :"/things/edit"
end

# update a thing
put '/things/:id' do
  @thing = find_and_ensure(params[:id])
  authenticate!
  authorize!(@thing.owner)
  @thing.assign_attributes(params[:thing])
  
  if @thing.save
    redirect "/things/#{params[:id]}"
  else
    @errors = @thing.errors.full_messages
    erb :'things/edit'
  end
end

# delete a specific thing
delete '/things/:id' do
  @thing = find_and_ensure(params[:id])
  authenticate!
  authorize!(@thing.owner)
  @thing.destroy
  redirect '/things'
end


