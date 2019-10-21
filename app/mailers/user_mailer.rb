class UserMailer < ApplicationMailer
  def welcome(email)
    @email = email
    mail(to:email, subject: "Signup SuccessFully")
  end
end
