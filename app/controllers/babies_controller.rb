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

    get '/babies/:slug/edit' do
        if_not_logged_in_redirect_to_index
        @baby = current_user.babies.find_by_slug(params[:slug])
        if @baby
            erb :'babies/edit'
        else
            erb :'babies/failure'
        end
    end

    patch '/babies/:slug' do
        binding.pry
        baby = Baby.find_by_slug(params[:slug])
        baby.update(name:params[:name], age:params[:age],gender:params[:gender],about_me:params[:about_me])
        redirect "/babies/#{baby.slug}"
    end

    get '/babies/:slug' do
        if_not_logged_in_redirect_to_index
        @baby = current_user.babies.find_by_slug(params[:slug])
        if @baby
            erb :'babies/show_baby'
        else
            erb :'babies/failure'
        end       
    end

    delete '/babies/:slug' do
        @baby = Baby.find_by_slug(params[:slug])
        @baby.destroy
        redirect '/babies'
    end

end