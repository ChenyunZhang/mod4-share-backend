class PostsController < ApplicationController
    def create
        # byebug
        post = Post.create(post_param)
        render json: post
    end

    def index
        posts =Post.all.sort{ |a, b| b <=> a }
        render json: posts
    end

    def destroy 
        post = Post.find_by(id: params[:id])
        post.destroy
        render json: post
    end

    private
    def post_param
        params.permit(:content, :image, :featured_image, :user_id)
    end
end
