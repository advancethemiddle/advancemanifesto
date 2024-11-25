class PledgesController < ApplicationController
  def new
    @pledge = Pledge.new
  end

  def create
    @pledge = Pledge.new(pledge_params)

    if safe_submission? && @pledge.save
      flash[:success] = "Thanks for signing! 🥳"
      PledgeMailer.new_pledge(
        first_name: pledge_params[:first_name],
        email: pledge_params[:email]
      ).deliver_later
      redirect_to :root
    else
      flash[:error] = "Eek! We had trouble saving your pledge. Please try again later."
      redirect_to :root
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:first_name, :last_name, :email)
  end

  def safe_submission?
    ::Recaptcha.new(
      token: params[:g_recaptcha_response]
    ).call
  end
end
