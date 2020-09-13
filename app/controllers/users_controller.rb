class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
        erb :'users/home'
    else
        erb :'users/create_user'
    end
 end

 post '/signup' do
    if_user_email_exist_redirect_to_login
    parent = Parent.new(params)
    if parent.save 
        session[:user_id] = parent.id
        redirect '/login'
    else
        redirect '/'
    end
 end

 get '/login' do
    if logged_in?
        parent = Parent.find(session[:user_id])
        redirect "/parents/#{parent.slug}"
    else
        erb :'users/login'
    end
 end

 post '/login' do
    parent = Parent.find_by(email: params[:email])
    if parent
        if parent.authenticate(params[:password])
           session[:user_id] = parent.id
           redirect "/parents/#{parent.slug}"
        else
           redirect '/login'
        end
    else
        redirect '/'
    end
 end

 get '/parents/:name' do
   @parent = Parent.find_by_slug(params[:name])
    erb :'users/home'
 end

 get '/logout' do
    if logged_in?
        session.clear
        redirect '/login'
    else
        redirect '/'
    end
 end
end 