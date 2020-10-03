class CommentsController < ApplicationController
    before do
        if_not_logged_in_redirect_to_index
    end

    post '/playdates/:id/comments' do
        @playdate = Playdate.find_by(id: params[:id])
        if @playdate && @comment = @playdate.comments.create(content: params[:content])
            @comment.commentor = current_user
            @comment.save
            redirect "/playdates/#{params[:id]}"
        else
            redirect "/playdates/#{params[:id]}"
        end
    end

    delete '/playdates/:playdate_id/comments/:comment_id' do
        comment = current_user.comments.find_by(id:params[:comment_id])
        comment.delete
        flash[:success] = "Comment is deleted successfully"
        redirect "/playdates/#{params[:playdate_id]}"
    end

end
