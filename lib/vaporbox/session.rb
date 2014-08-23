module Vaporbox

  # Provides simple access to Guerrilla Mail's api
  #
  # It helps track the special cookies required by
  # Guerrilla Mail so that state can be properly maintained across
  # requests
  #
  # The session is mutable. This isn't quite to my taste but Guerrilla
  # Mail states that they might change the session_id on the fly. When
  # this happens the session must bust any cached state it's
  # maintaining
  #
  # Wraps Guerrilla Mail API documented here:
  # https://docs.google.com/document/d/1Qw5KQP1j57BPTDmms5nspe-QAjNEsNg8cQHpAAycYNM/edit?hl=en
  # NOTE: The api documented on guerillamail.com is out-of-date
  class Session
    attr_accessor :session_id
    attr_accessor :client

    def self.start(address=nil)
      client = Client.new
      res = client.get("get_email_address")
      sid = JSON.parse(res.body)["sid_token"]
      session = self.new(client, sid)
      if address
        address = Address.new(address)
        session.set_email_user(address.username)
      end
      session
    end

    def initialize(client, sid)
      @session_id = sid
      @client = client
    end

    def subscription
      @subscription ||= Subscription.new(get("get_email_address"))
    end

    def set_email_user(email_user)
      @subscription = Subscription.new get("set_email_user", email_user: email_user)
    end

    def defaults
      { sid_token: @session_id }
    end

    def check_mail(sequence_id=nil)
      get "check_mail", seq: sequence_id
    end

    def get_email_list(offset=0, seq=nil)
      get "get_email_list", offset: offset, seq: sequence_id
    end

    def fetch_email(email_id)
      get "fetch_email", email_id: email_id
    end

    def del_email(email_ids)
      get "del_email", email_id: email_id
    end

    def extend
      get "extend", defaults
    end

    def send_email target, subject, body
      post "send_mail", from:subscription.address,to:target,subject:subject,body:body
    end

    private

    # returns hash of data returned from endpoint
    def get(function, params)
      params = defaults.merge(params)
      res = client.get(function, params)
      JSON.parse(res.body)
    end

    def post(function, params)
      params = defaults.merge(params)
      res = client.post(function, params)
      JSON.parse(res.body)
    end
  end
end
