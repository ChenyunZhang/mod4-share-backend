class CommentsController < ApplicationController    
    def create
    # byebug
        comment = Comment.create(comment_param)
        render json: comment
    end

    def index
        comments =Comment.all.sort{ |a, b| b <=> a }
        render json: comments
    end

    def destroy 
        comment = Comment.find_by(id: params[:id])
        comment.destroy
        render json: comment
    end

    private
    def comment_param
        params.permit(:content, :post_id, :user_id)
    end

end
