get '/' do
  puts "Session shit: #{session[:id]}"
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.authenticate(params[:email],params[:password])
  if @user
    session[:id] = @user.id 
    redirect to '/secret'
  else
    redirect to '/'
  end
end

get '/logout' do
  session.clear
  redirect to '/'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params)
  if @user.save
    redirect to '/'
  else
    @errors = @user.errors
    erb :signup
  end
end

get '/secret' do
  if session[:id]
    erb :secret
  else
    redirect to '/'
  end
end


