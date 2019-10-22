class ForgetpassWorker
  include Sidekiq::Worker

  def perform(email)
    UserMailer.forget_password(email).deliver_now
  end
end
