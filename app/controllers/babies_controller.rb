class BabiesController < ApplicationController
    before do
        if_not_logged_in_redirect_to_index
    end
    
    get '/babies' do  
        @babies = current_user.babies
        erb :'/babies/babies'
       
    end

    get '/babies/new' do
        erb :'babies/new'
    end

    post '/babies' do
        baby = current_user.babies.build(params)
        if baby.save
            flash[:success] = "You have successfully created the baby profile"
            redirect "/babies/#{baby.slug}"
        else
            flash[:error] = "Please fill in information for all * area"
            redirect '/babies/new'
        end
    end

    get '/babies/:slug/edit' do
        set_baby
        if @baby
            erb :'babies/edit'
        else
            flash[:error] = "Baby profile cannot be found"
            redirect "/parents/#{current_user.slug}"
        end
    end

    patch '/babies/:slug' do
       set_baby
        if @baby.update(name:params[:name], age:params[:age], gender:params[:gender],about_me:params[:about_me])
            flash[:success] = "You have successfully updated the record"
            redirect "/babies/#{@baby.slug}"
        elsif 
           flash[:error] = "Please fill in information for all * area"
           redirect "/babies/#{params[:slug]}/edit"
        end
    end

    get '/babies/:slug' do
       set_baby
        if @baby
            erb :'babies/show_baby'
        else
            flash[:error] = "Baby profile cannot be found "
            redirect "/parents/#{current_user.slug}"
        end       
    end

    delete '/babies/:slug' do
        set_baby
        @baby.destroy
        flash[:success] = "You have successfully deleted the record"
        redirect '/babies'
    end

end