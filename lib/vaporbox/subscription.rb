module Vaporbox
  class Subscription
    attr_accessor :address
    attr_accessor :created_at
    attr_accessor :alias

    def username
      address.split("@")[0]
    end

    def initialize(attributes)
      @address = attributes["email_addr"]
      @created_at = attributes["email_timestamp"]
      @alias = attributes["alias"]
    end
  end
end
