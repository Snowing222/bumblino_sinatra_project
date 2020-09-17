class PlaydatesController < ApplicationController
    #render new playdate form
    get '/playdates/new' do
        if_not_logged_in_redirect_to_index
        erb :'/playdates/new'
    end
    
    #post new playdate to db/create instance-both attributes & relation
    post '/playdates' do
        @playdate = current_user.playdates.new(title:params[:title],date:params[:date],location:params[:location],zipcode:params[:zipcode],description:params[:description])
        
        if  !params[:babies].nil? && @playdate.save
            params[:babies]. each do |baby_id|
              baby = Baby.find(baby_id)
              @playdate.babies << baby
            end
            flash[:success] = "You have successfully created playdate"
            redirect "/playdates/#{@playdate.id}"
        else
            flash[:error] = "Please fill in information for all * area"
            redirect '/playdates/new'
        end    
        
     end
  
    #find all playdates for current user
    get '/playdates' do
        if_not_logged_in_redirect_to_index
        @playdates = current_user.playdates
        erb :'playdates/playdates'
    end
    
    #
    get '/playdates/:id/edit' do
        if_not_logged_in_redirect_to_index
        @playdate = current_user.playdates.find_by(id: params[:id])
        if @playdate
            erb :'playdates/edit_playdate'
        else
            flash[:error] = "playdate record cannot be found "
            redirect "/parents/#{current_user.slug}"
        end
    end

    patch '/playdates/:id' do
        playdate = current_user.playdates.find_by(id: params[:id])
        playdate.update(title:params[:title],date:params[:date],location:params[:location],zipcode:params[:zipcode],description:params[:description])
        if playdate &&  !playdate.baby_ids.nil?
           playdate.baby_ids = params[:babies]  
           flash[:success] = "You have successfully updated playdate"
           redirect "/playdates/#{playdate.id}"  
        else
            flash[:success] = "Please fill in information for all * area"
            redirect "/playdates/#{params[:id]}/edit"
        end
    end

    #find target playdate, and render show page
    get '/playdates/:id' do
        if_not_logged_in_redirect_to_index
    
        @playdate = current_user.playdates.find_by(id: params[:id])
        if @playdate
            erb :'playdates/show_playdate'
        else
            flash[:error] = "playdate record cannot be found "
            redirect "/parents/#{current_user.slug}"
        end
    end

    delete '/playdates/:id' do
        playdate = Playdate.find_by(id: params[:id])
        playdate.destroy
        flash[:error] = "The playdate is successfully deleted"
        redirect '/playdates'
    end
  
  
end
  