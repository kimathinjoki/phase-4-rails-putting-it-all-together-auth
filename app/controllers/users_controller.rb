class UsersController < ApplicationController


    before_action :authorize, only: :show

    def create 

        user = User.create(user_params)

        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: user.errors.full_message}, status: :unprocessable_entity
        end

    end

    def show 

        user = User.find(session[:user_id])
 
        render json: user, status: :created 

    end



    private

    def user_params 

        params.permit(:id, :username, :password, :image_url, :bio)

    end

    def authorize 

        unless session.include? :user_id
            render json: {message: "Not authorized"}, status: :unauthorized
        end

    end


end
