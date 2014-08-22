module Vaporbox
  # wraps each item returned from MG's "check_email" endpoint
  class MailHeader
    attr_reader :id
    attr_reader :from
    attr_reader :subject
    attr_reader :excerpt
    attr_reader :timestamp
    attr_reader :read
    attr_reader :timestamp
    attr_reader :date

    def initialize(hash)
      hash.each do |k,v|
        attr = k.sub("mail_", "") + "="
        __send__(attr, v)
      end
    end

    def read?
      read
    end

  end
end

