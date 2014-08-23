module Vaporbox
  class Address
    attr_reader :username
    attr_reader :domain

    def initialize(address)
      address = address.to_s
      @username = address.split("@")[0]
      @domain = address.split("@")[1] || "guerrillamail.com"
    end

    def address
      "#{@username}@#{domain}"
    end

    def to_s
      address
    end
  end
end
