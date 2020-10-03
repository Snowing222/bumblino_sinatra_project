class UsersController < ApplicationController
   #render sign up form, if user is not currently login
 get '/signup' do
    if_logged_in_redirect_to_user_home
    erb :'users/create_user'
 end

 post '/signup' do
   binding.pry
    parent = Parent.new(params)
    if find_user_account  
        flash[:error] = "User account exists, Please log in"
        redirect '/login'
    elsif parent.save
        session[:user_id] = parent.id
        flash[:success] = "Account is successfully created"
        redirect "/parents/#{parent.slug}"
    else
        flash[:error] = "Please fill in information for all * area"
        redirect '/signup'
    end
 end
    
    #render log in form, if user is not currently login
 get '/login' do
    if_logged_in_redirect_to_user_home
    erb :'users/login'
 end

    #find user? authenticate user? log authenticatd user in(set sesseion[:user_id])
 post '/login' do
    login_authenticated_user_redirect_to_user_home
    if !find_user_account
      flash[:error] = "Your account does not exist, Please sign up"
      redirect '/signup'
    else
      flash[:error] = "Missing information or Incorrect logIn credential"
      redirect '/login'
    end
 end

 get '/parents/:name' do
    @parent = Parent.find_by_slug(params[:name])
    if @parent && current_user && current_user.id == @parent.id
       erb :'users/home'
    else
      logout_logged_in_user_redirect_to_login
      flash[:error] = "Please Signup or Login"
       redirect '/'
    end
 end

 get '/logout' do
    logout_logged_in_user_redirect_to_login
    flash[:success] = "You have successfully logged out. See you Next time!"
    redirect '/'
 end
end 
