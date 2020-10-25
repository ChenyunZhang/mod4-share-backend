class UsersController < ApplicationController
    before_action :authorized, only: [:keep_logged_in]
    
    def index
        users = User.all.sort{ |a, b| a <=> b }
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
                render json: {error: "This email address is alredy being registered"}, status: 422
            end
        else
            render json: {error: "Incorrect email address/password"}, satus: 422
        end
    end
    

    def keep_logged_in
        # @user exists here because of the before_action
        wristband_token = encode_token({user_id: @user.id})

        render json: {
            user: UserSerializer.new(@user),
            token: wristband_token
        }
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end


    private
    def user_params
        params.permit(:username, :gender, :password, :email, :location)
    end
end

