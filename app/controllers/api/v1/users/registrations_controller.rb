module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      def create
        user = User.find_by(email: params[:user][:email])
        if user.present?
          render json: {status: "Error",data: user.errors}
        else
          user = User.create(signup_params)
          render json: {status:"Sucsess", data: user}
        end
      end

      private
      def signup_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
