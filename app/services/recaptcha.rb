require "net/http"
require "uri"

class Recaptcha
  def initialize(token:)
    @token = token
  end

  def call
    endpoint = "https://www.google.com/recaptcha/api/siteverify"
    data = {
      secret: ENV["G_RECAPTCHA_SECRET_KEY"],
      response: @token
    }
    response = Net::HTTP.post_form URI(endpoint), data
    payload = JSON.parse(response.body)
    threshold = ENV.fetch("G_RECAPTCHA_SCORE_THRESHOLD", "0.5").to_f

    if payload["success"] && payload["score"] > threshold
      Rails.logger.info "reCAPTCHA evaluated as safe: payload => #{payload}"
      true
    else
      Rails.logger.warn "reCAPTCHA evaluated as unsafe: payload => #{payload}"
      false
    end

  rescue StandardError => exception
    Rails.logger.error "Form response failed to validate with reCAPTCHA: exception => #{exception}, payload => #{payload}"
    false
  end
end
