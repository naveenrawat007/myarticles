module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      def create
        @user = User.find_by(email:params[:user][:email])
        if @user.active
          if @user&.valid_password?(params[:user][:password])
            token = JWT.encode({user_id: @user.id}, 'HS512')
            render json: {token: token, user_id: @user.id, status: 200}
          else
            render json: {message:"invalid username/password", status: 401, data: nil}
          end
        else
          render json: {message: "please verify otp first", status: 401, data: nil}
        end
      end
    end
  end
end
