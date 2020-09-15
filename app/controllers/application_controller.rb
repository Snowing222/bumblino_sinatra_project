require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    @playdates = Playdate.all
    erb :index
  end

  helpers do 
    def logged_in?
      session[:user_id]
    end

    def current_user
      Parent.find(session[:user_id])
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

  end
end
