class CommentsController < ApplicationController
    get '/comments/:id/new' do
        if_not_logged_in_redirect_to_index
        if @playdate = Playdate.find_by(id: params[:id])
            erb :'comments/new'
        else
            flash[:error] = "Cannot find record"
            redirect "/parents/#{current_user.slug}"
        end
    end

    post '/comments/:id' do
        @playdate = Playdate.find_by(id: params[:id])
        if @playdate && @comment = @playdate.comments.create(content: params[:content])
            @comment.commentor = current_user
            @comment.save
            redirect "/comments/#{params[:id]}"
        else
            redirect "playdates/#{params[:id]}"
        end
    end

    get '/comments/:id' do
        if_not_logged_in_redirect_to_index
        if @playdate = Playdate.find_by(id: params[:id])
            erb :'comments/comments'
        else
            flash[:error] = "Cannot find record"
            redirect "/parents/#{current_user.slug}"
        end
    end

    delete '/comments/:id' do
        if_not_logged_in_redirect_to_index
        comment = current_user.comments.find_by(id:params[:id])
        playdate = comment.playdate
        comment.delete
        flash[:success] = "Comment is deleted successfully"
        redirect "/comments/#{playdate.id}"
    end

end
