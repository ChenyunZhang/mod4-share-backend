class RelationshipsController < ApplicationController

        def create
            relationship = Relationship.create(post_param)
            render json: relationship
        end
    
        def index
            relationships =Relationship.all.sort{ |a, b| b <=> a }
            render json: relationships
        end
    
        def destroy 
            relationship = Relationship.find_by(id: params[:id])
            relationship.destroy
            render json: relationship
        end
    
        private
        def post_param
            params.permit(:follower_id, :followed_id)
        end
end
