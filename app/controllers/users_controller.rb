class UsersController < ApplicationController
  get '/signup' do
    if_logged_in_redirect_to_user_home
    erb :'users/create_user'
 end

 post '/signup' do
    parent = Parent.new(params)
    if find_user_account 
        redirect '/login'
    elsif parent.save
        session[:user_id] = parent.id
        redirect '/login'
    else
        redirect '/signup'
    end
 end

 get '/login' do
    if_logged_in_redirect_to_user_home
    erb :'users/login'
 end

 post '/login' do
    login_authenticated_user_redirect_to_user_home
    if find_user_account
        redirect '/login'
    else
        redirect '/signup'
    end
 end

 get '/parents/:name' do
    @parent = Parent.find_by_slug(params[:name])
    if @parent
       erb :'users/home'
    else
        rediret '/'
    end
 end

 get '/logout' do
    logout_logged_in_user_redirect_to_login
    redirect '/'
 end
end 
