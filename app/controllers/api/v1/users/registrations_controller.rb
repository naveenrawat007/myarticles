module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      def create
        user = User.find_by(email: params[:user][:email])
        if user.present?
          render json: {error: "User already exist with this email",status: 409}
        else
          user = User.new(signup_params)
          if (user.save)
            Sidekiq::Client.enqueue_to_in("default",Time.now, WelcomeMailWorker, user.email)
            render json: {user: UserSerializer.new(user, root: false), message: "SuccessFully saved "}
          end
        end
      end

      private
      def signup_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
