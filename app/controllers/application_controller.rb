require './config/environment'

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

    def if_not_logged_in_redirect_to_index
      if !logged_in?
        redirect '/'
      end
    end

    def if_user_email_exist_redirect_to_login
      email = Parent.find_by(email: params[:email])
      if email 
        redirect '/login'
      end
    end
  end

end
