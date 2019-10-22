module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      def create
        @user = User.find_by(email:params[:email])
        if @user&.valid_password?(params[:password])
          token = JWT.encode({user_id: @user.id}, 'HS512')
          render json: {token: token, user_id: @user.id}
        else
          render json: {message:"invalid username/password", status: 401, data: nil}
        end
      end
    end
  end
end
