module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      def create
        user = User.find_by(email: params[:user][:email])
        if user.present?
          render json: {message: "User already exist with this email",status: 409,data: nil}
        else
          user = User.new(signup_params)
          if (user.save)
            Sidekiq::Client.enqueue_to_in("default",Time.now, WelcomeMailWorker, user.email)
            render json: {user: UserSerializer.new(user, root: false), message: "SuccessFully saved",status: 200}
          else
            render json: {error: user.errors, message: "not saved"}
          end
        end
      end

      private
      def signup_params
        params.require(:user).permit(:email, :password, :name, :gender, :date_of_birth)
      end
    end
  end
end
