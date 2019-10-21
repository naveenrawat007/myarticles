class WelcomeMailWorker
  include Sidekiq::Worker

  def perform(email)
    UserMailer.welcome(email).deliver_now
  end
end
