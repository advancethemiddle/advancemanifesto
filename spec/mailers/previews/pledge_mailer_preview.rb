# Preview all emails at http://localhost:3000/rails/mailers/pledge_mailer
class PledgeMailerPreview < ActionMailer::Preview
  def new_pledge
    PledgeMailer.new_pledge(first_name: pledge.first_name, email: pledge.email)
  end

  def goodbye
    PledgeMailer.goodbye(first_name: pledge.first_name, email: pledge.email)
  end

  private

  def pledge
    @pledge ||= Pledge.find_or_create_by(first_name: "Sans", last_name: "Serif", email: "fontswithoutfoots@example.net")
  end
end
