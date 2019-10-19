# frozen_string_literal: true
module Api
  module V1
    class User::RegistrationsController < Devise::RegistrationsController
      def create
        user = User.find_by(email:params[:email])
        if user.exists?
          render json: {status:"Error", data: user.errors}
        else
          user = User.new(email:params[:email],password:params[:password])
          if user.save
            render json: user
          end
        end
      end
    end
  end
end
