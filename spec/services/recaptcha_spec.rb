require "rails_helper"

describe Recaptcha do
  subject { described_class.new(token: double) }

  describe "#call" do
    let(:response) { double body: "{\n  \"success\": true,\n  \"challenge_ts\": \"2024-11-25T00:03:52Z\",\n  \"hostname\": \"example.net\",\n  \"score\": 0.9,\n  \"action\": \"submit\"\n}" }

    before do
      allow(Rails.logger).to receive_messages(info: nil, warn: nil, error: nil)
      allow(Net::HTTP).to receive(:post_form).and_return response
    end

    context "safe form submission" do
      it "logs an info message and returns true" do
        expect(subject.call).to eq true
        expect(Rails.logger).to have_received(:info)
      end
    end

    context "unsafe form submission" do
      let(:response) { double body: "{\n  \"success\": false,\n  \"challenge_ts\": \"2024-11-25T00:03:52Z\",\n  \"hostname\": \"example.net\",\n  \"score\": 0.1,\n  \"action\": \"submit\"\n}" }

      it "logs a warning message and returns false" do
        expect(subject.call).to eq false
        expect(Rails.logger).to have_received(:warn)
      end
    end

    context "invalid reCAPTCHA call" do
      let(:response) { double body: "{\n  \"success\": false,\n  \"error-codes\": [\n    \"invalid-input-response\"\n  ]\n}" }

      it "logs a warning message and returns false" do
        expect(subject.call).to eq false
        expect(Rails.logger).to have_received(:warn)
      end
    end

    context "StandardError" do
      before do
        allow(Net::HTTP).to receive(:post_form).and_raise(StandardError)
      end

      it "logs an error message and returns false" do
        expect(subject.call).to eq false
        expect(Rails.logger).to have_received(:error)
      end
    end
  end
end
