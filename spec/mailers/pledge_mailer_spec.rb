require "rails_helper"

describe PledgeMailer do
  describe "#new_pledge" do
    subject do
      described_class.new_pledge(
        first_name: first_name,
        email: email
      ).deliver_now
    end
    let(:first_name) { "Feline" }
    let(:email) { "felinegood@example.net" }

    it "sends a message to the provided email address" do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
      delivery = ActionMailer::Base.deliveries.first
      sent_to = delivery.to.first
      expect(sent_to).to eq email
    end

    it "addresses the advancer by name" do
      parts = subject.parts
      html_part = parts.find { |part| part.content_type.include?("text/html") }
      text_part = parts.find { |part| part.content_type.include?("text/plain") }
      expect(subject.subject).to have_text first_name
      expect(html_part).to have_text first_name
      expect(text_part).to have_text first_name
    end
  end

  describe "#goodbye" do
    subject do
      described_class.goodbye(
        first_name: first_name,
        email: email
      ).deliver_now
    end
    let(:first_name) { "Feline" }
    let(:email) { "felinegood@example.net" }

    it "sends a message to the provided email address" do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
      delivery = ActionMailer::Base.deliveries.first
      sent_to = delivery.to.first
      expect(sent_to).to eq email
    end

    it "addresses the advancer by name" do
      parts = subject.parts
      html_part = parts.find { |part| part.content_type.include?("text/html") }
      text_part = parts.find { |part| part.content_type.include?("text/plain") }
      expect(subject.subject).to have_text first_name
      expect(html_part).to have_text first_name
      expect(text_part).to have_text first_name
    end
  end
end
