require "rails_helper"

describe PledgesController do
    include ActionMailer::TestHelper
    include ActiveJob::TestHelper

    describe "#create" do
    let(:first_name) { "Isaac" }
    let(:last_name) { "Newton" }
    let(:email) { "inewton@example.net" }
    let(:token) { "motion_token" }
    let(:params) do
      {
        pledge: {
          first_name: first_name,
          last_name: last_name,
          email: email,
          g_recaptcha_response: token
        }
      }
    end
    let(:recaptcha_stub) { double call: true }

    before do
      allow(Recaptcha).to receive(:new).and_return recaptcha_stub
      post "/pledges", params: params
    end

    it "creates a new pledge" do
      expect(Pledge.count).to eq 1
    end

    it "enqueues an email job" do
      expect(enqueued_jobs.first[:job]).to eq ActionMailer::MailDeliveryJob
    end

    it "redirects to the root" do
      expect(response.code).to eq "302"
    end
  end
end
