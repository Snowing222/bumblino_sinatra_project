require './config/environment'
require 'pry'
# require 'sinatra/base'
# require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
   
  end

  get '/' do
    if logged_in?
      redirect "/parents/#{current_user.slug}"
    else
      flash[:error] = "Please Sign Up or Log in to see more information"
      @playdates = Playdate.all
      erb :index
    end
  end

  helpers do 
    def logged_in?
      !!current_user
    end

    def current_user
      Parent.find_by(id:session[:user_id])
    end

    def if_logged_in_redirect_to_user_home
      if logged_in?
         redirect "/parents/#{current_user.slug}"
      end
    end

    def if_not_logged_in_redirect_to_index
      if !logged_in?
        redirect '/'
      end
    end
    
    def find_user_account
      Parent.find_by(email: params[:email])
    end

    def login_authenticated_user_redirect_to_user_home
      if find_user_account && find_user_account.authenticate(params[:password])
        session[:user_id] = find_user_account.id
        redirect "/parents/#{current_user.slug}"
      end
    end

    def logout_logged_in_user_redirect_to_login
      if logged_in? 
         session.clear
         redirect '/login' 
      end
    end

    def delete_user_dup_playdates
      current_user.playdates.uniq
    end

    def set_playdate
      @playdate = current_user.created_playdates.find_by(id: params[:id])
    end

  end
end
