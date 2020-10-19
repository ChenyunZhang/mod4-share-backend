class UsersController < ApplicationController
    def index
        users = User.all.sort{ |a, b| b <=> a }
        render json: users
    end

    def login
        # byebug
        user = User.find_by(email: params[:email])
        if !!(user && user.authenticate(params[:password]))
            wristband_token = encode_token({user_id: user.id})

            render json: {
                user: UserSerializer.new(user),
                token: wristband_token
            }
        elsif !!user_params[:username]
            user = User.create(user_params)
            if user.valid?
                wristband_token = encode_token({user_id: user.id})
    
                render json: {
                    user: UserSerializer.new(user),
                    token: wristband_token
                }
            else
                render json: {error: "INVALID EMAIL ADDRESS"}, status: 422
            end
        else
            render json: {error: "INVALID EMAIL ADDRESS/PASSWORD"}, satus: 422
        end
    end
    
    private
    def user_params
        params.permit(:username, :password, :email)
    end
end

