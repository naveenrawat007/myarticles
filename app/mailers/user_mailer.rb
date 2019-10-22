class UserMailer < ApplicationMailer
  def welcome(email,code)
    @email = email
    @code = code
    mail(to:email, subject: "Signup SuccessFully")
  end
end
