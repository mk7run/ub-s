# render login page
get '/sessions/new' do
  erb :"session/new"
end

# check database if the user exists/password is correct to allow user into app
post '/sessions' do
  @user = User.find_by(username: params[:username])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    @message = "Either you username or password was wrong"
    erb :"session/new"
  end
end

# when user decides to log out of the page, delete the session and redirect the page to index so no one can access their shit
delete '/sessions' do
  session.delete(:user_id)
  redirect '/'
end

# render unauthorized page
get '/not_authorized' do
  erb :not_authorized
end
