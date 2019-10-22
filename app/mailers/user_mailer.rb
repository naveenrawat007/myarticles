class UserMailer < ApplicationMailer
  def welcome(email,code)
    @email = email
    @code = code
    mail(to:email, subject: "Signup SuccessFully")
  end

  def forget_password(email)
    @email = email
    @url = 'https://account.genndi.com/login'
    mail(to:email, subject: "Forget Password")
  end
end
