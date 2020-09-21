class AttendPlaydatesController < ApplicationController
    delete '/attend_playdates/:id' do
        playdate = Playdate.find_by(id: params[:id])
        current_user.attended_playdates.delete(playdate)
        redirect "/parents/#{current_user.slug}"
    end

    get '/attend_playdates/:id/new' do
        @playdate = Playdate.find_by(id: params[:id])
        erb :'attend_playdates/new'
    end

    post '/attend_playdates/:id' do
        playdate = Playdate.find_by(id: params[:id])
        current_user.attended_playdates << playdate
        flash[:success] = "You are all set for this playdate"
        redirect "/parents/#{current_user.slug}"
    end

    get '/attend_playdates' do
        @attended_playdates = current_user.attended_playdates
        erb :'/attend_playdates/attend_playdates'
    end

end
