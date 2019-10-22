class WelcomeMailWorker
  include Sidekiq::Worker

  def perform(email,code)
    UserMailer.welcome(email,code).deliver_now
  end
end
