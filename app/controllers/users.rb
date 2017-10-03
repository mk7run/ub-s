# render a register user page
get '/users/new' do
  @user = User.new
  erb :"users/new"
end

# retrieve info from registration to database
post '/users' do
  @user = User.new(params[:user])

  if @user.save
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :"users/new"
  end
end

# display about particular user
get '/users/:id' do
  @user = User.find_by(id: params[:id])
  erb :"users/show"
end
