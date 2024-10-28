class PledgeMailer < ApplicationMailer
  def new_pledge(**params)
    @email = params[:email]
    @first_name = params[:first_name]
    subject = "Thanks for your pledge, #{@first_name}!"
    mail(to: @email, subject: subject)
  end
end
