require 'forwardable'

module Vaporbox

  # Provides simple access to a temporary mailbox
  #
  # It wraps Guerrilla Mail's concept of a subscriber
  class Mailbox

    # returns a mailbox for a specific address
    def self.find_or_create(address)
      new(address)
    end

    # returns a mailbox for a random address
    def self.create
      new
    end

    attr_reader :address
    attr_reader :session

    # @params address
    #   The address for the temporary mailbox
    def initialize(address=nil)
      @address = address
      @session = Session.start(address)
    end

    def subscription
      session.subscription
    end

    def username
      subscription.username
    end

    def address
      subscription.address
    end

    def domain
      subscription.domain
    end

    def created_at
      subscription.created_at
    end

    def alias
      subscription.alias
    end

    def empty?
      messages.count == 0
    end

    def messages
      session.refresh
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
