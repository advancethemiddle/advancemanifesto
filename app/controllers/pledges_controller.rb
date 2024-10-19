class PledgesController < ApplicationController
  def new
    @pledge = Pledge.new
  end

  def create
    @pledge = Pledge.new(pledge_params)

    if @pledge.save
      flash[:success] = "Thanks for signing! 🥳"
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
end
