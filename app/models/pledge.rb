class Pledge < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  after_create_commit -> { broadcast_update_later_to "pledge_count", target: "pledge_count", partial: "pledges/pledge_count" }
end
