class PlaydatesController < ApplicationController
    get '/playdates/new' do
        if_not_logged_in_redirect_to_index
        erb :'/playdates/new'
    end

    post '/playdates' do
        
        playdate = Playdate.new
        playdate.title = params['title']
        playdate.date = params['date']
        playdate.location = params['location']
        playdate.zipcode = params['zipcode']
        playdate.description = params['description']
        playdate.baby_ids = params['babies']
     
        if  playdate.save
            redirect "/playdates/#{playdate.id}"
        else
            redirect '/playdates/new'
        end
        	
    end

    get '/playdates/:id' do
        if_not_logged_in_redirect_to_index
        @playdate = Playdate.find_by(id: params[:id])
        if @playdate
            erb :'playdates/show_playdate'
        else
            erb :'/playdates/failure'
        end
    end

    get '/playdates' do
        if_not_logged_in_redirect_to_index
        if current_user.id == session[:user_id]
            erb :'playdates/playdates'
        else
            redirect '/login'
        end
    end

    get '/playdates/:id/edit' do
        if_not_logged_in_redirect_to_index
        @playdate = Playdate.find(params[:id])
        if current_user.id == session[:user_id] 
            if @playdate
                erb :'playdates/edit_playdate'
            else
                erb :'/playdates/failure'
            end
        else
            redirect '/login'
        end
    end

    patch '/playdates/:id' do
        playdate = Playdate.find_by(id: params[:id])
        playdate.title = params['title']
        playdate.date = params['date']
        playdate.location = params['location']
        playdate.zipcode = params['zipcode']
        playdate.description = params['description']
        playdate.baby_ids = params['babies']
        redirect "/playdates/#{playdate.id}"
          
    end

    delete '/playdates/:id' do
        playdate = Playdate.find_by(id: params[:id])
        playdate.destroy
        redirect '/playdates'

    end
  
  
end
  