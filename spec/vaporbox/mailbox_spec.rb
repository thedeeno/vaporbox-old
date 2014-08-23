require "spec_helper"
require 'vaporbox'

module Vaporbox

  describe Mailbox do

    describe ".find_or_create" do
      it "returns the mailbox with username" do
        m = Mailbox.find_or_create("test")
        expect(m.username).to eq("test")
      end
      it "accepts supported domains" do
        m = Mailbox.find_or_create("test@guerrillamail.com")
        expect(m.address).to eq("test@guerrillamail.com")
      end
    end

    describe ".create" do
      it "returns mailbox with random username" do
        m = Mailbox.create
        expect(m.address).to_not be_nil
        expect(m.address).to_not be_empyt
      end
    end

    describe "construction" do
      it "new mailboxes should have no messages" do
        expect(Mailbox.new).to be_empty
      end
      it "complains when given an invalid domain" do
        m = Mailbox.new
      end
      it "handles just usernames" do

      end
    end

    # SMTP_PORT = ENV["MAILCATCHER_SMTP_PORT"]
    # HTTP_PORT = ENV["MAILCATCHER_HTTP_PORT"]
    # DEFAULT_FROM = "from@example.com"
    # DEFAULT_TO = "to@example.com"



    # before do
    #   server.clear
    # end

    # let(:server) { MailServer.new("http://127.0.0.1:#{HTTP_PORT}") }
    # let(:address) { "test@example.com" }
    # let(:box) { server.mailbox(address) }

    it "starts with no messages" do
      expect(box).to be_empty
    end
#
#     describe "#messages" do
#       it "includes only messages delivered to its address" do
#         deliver("SUBJECT: a")
#         deliver("SUBJECT: b", to: address)
#         expect(box.messages.length).to eq(1)
#         expect(box.messages[0]["subject"]).to eq("b")
#       end
#     end
#
#     describe "#has_message?" do
#       it "looks for message for address with subject" do
#         deliver("SUBJECT: a")
#         expect(box).to_not have_message("a")
#         deliver("SUBJECT: a", to: address)
#         expect(box).to have_message("a")
#       end
#     end
#
#     describe "#clear" do
#       xit "only removes messages for this mailbox" do
#         deliver("SUBJECT: a")
#         deliver("SUBJECT: b", to: address)
#         deliver("SUBJECT: c", to: address)
#         expect(server.messages.count).to eq(3)
#         box.clear
#         expect(box).to be_empty
#       end
#     end
#
#     def deliver(message, options={})
#       options = {:from => DEFAULT_FROM, :to => DEFAULT_TO}.merge(options)
#       Net::SMTP.start('127.0.0.1', SMTP_PORT) do |smtp|
#       smtp.send_message message, options[:from], options[:to]
#     end

  end
end
