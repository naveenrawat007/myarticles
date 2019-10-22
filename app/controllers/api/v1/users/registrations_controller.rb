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
            user.update(code: rand(100000...999999))
            Sidekiq::Client.enqueue_to_in("default",Time.now, WelcomeMailWorker, user.email, user.code)
            render json: {user: UserSerializer.new(user, root: false), message: "SuccessFully saved",status: 201}
          else
            render json: {error: user.errors, message: "not saved"}
          end
        end
      end

      def verify_otp
        user = User.find_by(code:params[:code])
        if (user!=nil)
          user.update(active: true)
          render json: {message: "OTP verified", data: user.id, status: 200}
        else
          render json: {message: "invalid otp code/expire code", status:404}
        end
      end

      def resend_otp
        user = User.find_by(email:params[:email])
        if user.present?
          user.update(code: rand(100000...999999))
          Sidekiq::Client.enqueue_to_in("default", Time.now, WelcomeMailWorker, user.email, user.code)
          render json: {message: "Resend OTP to your email", status: 201}
        end
      end

      private
      def signup_params
        params.require(:user).permit(:email, :password, :name, :gender, :date_of_birth)
      end
    end
  end
end
