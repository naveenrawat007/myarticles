module Api
  module V1
    class User::RegistrationsController < Devise::RegistrationsController
      # def create
      #   user = User.find_by(email:params[:email])
      #   if user.exists?
      #     render json: {status:"Error", data: user.errors}
      #   else
      #     user = User.new(user_params)
      #     if user.save
      #       render json: user
      #     end
      #   end
      # end
      def create
        resource = User.new(user_params)
        if resource.save
          render json: resource
        end
      end

      private
      def user_params
        params.require(:user).permit(:email,:password)
      end
    end
  end
end
