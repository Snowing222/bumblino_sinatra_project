class BabiesController < ApplicationController

    get '/babies' do
        if_not_logged_in_redirect_to_index
        
        @babies = current_user.babies
        erb :'/babies/babies'
       
    end

    get '/babies/new' do
        if_not_logged_in_redirect_to_index
        erb :'babies/new'
    end

    post '/babies' do
        baby = current_user.babies.build(params)
        if baby.save
            redirect "/babies/#{baby.slug}"
        else
            redirect '/babies/new'
        end
    end

    get '/babies/:name/edit' do
        if_not_logged_in_redirect_to_index
        @baby = Baby.find_by_slug(params["name"])
        if current_user.babies.include?(@baby)
            erb :'babies/edit'
        else
            redirect '/login'
        end
    end

    patch '/babies/:name' do
        @baby = Baby.find_by_slug(params["name"])
        @baby.update(name:params[:name], age:params[:age],gender:params[:gender],about_me:params[:about_me])
        redirect "/babies/#{@baby.slug}"
    end

    get '/babies/:name' do
        @baby = Baby.find_by_slug(params["name"])
        erb :'babies/show_baby'
    end

    delete '/babies/:name' do
        @baby = Baby.find_by_slug(params["name"])
        @baby.destroy
        redirect '/babies'
    end

end