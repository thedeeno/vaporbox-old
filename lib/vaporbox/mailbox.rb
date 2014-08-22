module Vaporbox

  # Provides simple access to a temporary mailbox
  #
  # It wraps Guerrilla Mail's concept of a subscriber
  class Mailbox

    # returns a mailbox for a specific address
    def self.find_or_create(address)

    end

    # returns a mailbox for a random address
    def self.create

    end

    # @params address
    #   The address for the temporary mailbox
    def initialize(subscription)
      @subscription = subscription
    end

    def username
      client.address.split("@")[0]
    end

    def address
      client.address
    end

    def empty?
      messages.count == 0
    end

    def messages
      @session.refresh
    end

    # lazy start the client for random email address if not set
    def client
      @client ||= Client.start
    end

    def messages
      client.messages(address)
    end

    def has_message?(subject)
      messages.count{|x| x["subject"] == subject } > 0
    end

    def clear
      messages.each{|x| server.delete_message(x["id"])}
    end

    def empty?
      messages.length == 0
    end

  end

end
