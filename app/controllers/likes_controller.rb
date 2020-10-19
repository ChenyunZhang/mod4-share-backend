class LikesController < ApplicationController

    def index
        likes = Like.all
        render json: likes
    end

    def create
        like = Like.create(like_param)
        render json: like
    end

    def destroy 
        like = Like.find_by(id: params[:id])
        like.destroy
        render json: like
    end

    private
    def like_param
        params.permit(:user_id,:post_id)
    end
end
