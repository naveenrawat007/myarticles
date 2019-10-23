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
            user.update(otp_expire: Time.now + 5.minutes)
            Sidekiq::Client.enqueue_to_in("default",Time.now, WelcomeMailWorker, user.email, user.code)
            render json: {user: UserSerializer.new(user, root: false), message: "SuccessFully saved",status: 201}
          else
            render json: { message: "User data not saved", status: 404}
          end
        end
      end

      def verify_otp
        user = User.find_by(code:params[:code])
        if (user.present?)
          if (user.otp_expire > Time.now)
            user.update(active: true)
            render json: {message: "OTP verified", data: user.id, status: 200}
          else
            render json: {message: "invalid OTP code/expired OTP code", status:404}
          end
        else
          render json: {message: "Cannot find user", status: 404}
        end
      end

      def resend_otp
        user = User.find_by(email:params[:email])
        if user.present?
          user.update(code: rand(100000...999999))
          user.update(otp_expire: Time.now + 5.minutes)
          Sidekiq::Client.enqueue_to_in("default", Time.now, WelcomeMailWorker, user.email, user.code)
          render json: {message: "Resend OTP to your email", status: 200, data: nil}
        end
      end

      def forget_password
        user = User.find_by(email:params[:email])
        if user.present?
          Sidekiq::Client.enqueue_to_in("default", Time.now, ForgetpassWorker, user.email)
          render json: {message: "reset_password link send to your email", status: 200}
        end
      end

      def reset_forget_password
        user = User.find(params[:id])
        if user.present?
          if (params[:new_password] == params[:confirm_password])
            user.update(password: params[:new_password])
            render json: {message: "SuccessFully reset password", status: 200, data:nil}
          else
            render json: {message: "password mismatch", status: 401, data: nil}
          end
        else
          render json: {message: "Cannot find person", status: 401, data:nil}
        end
      end

      def update_profile
        user = User.find(params[:user][:id])
        if user.update(signup_params)
          render json: {message: "SuccessFully Update data", status: 200, data: nil}
        else
          render json: {message: "n"}
        end
      end

      private
      def signup_params
        params.require(:user).permit(:email, :password, :name, :gender, :date_of_birth)
      end
    end
  end
end
