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
  class Session
    attr_reader :address, :subscriber_id

    def initialize(subscriber_id)
      @ip = "127.0.0.1"
      @agent = "vaporbox-gem"
      @subscriber_id = subscriber_id
      res = get!("get_email_address", { subscr: subscriber_id })
      Json.parse(res.body)

      @address = json["email_addr"]
      @subcription_active = json["email_addr"]
      @date = json["email_addr"]
      @address = json["email_addr"]
    end

    def get!(function, params)
      Client.send(function, params, session_id)
        f: function,
        agent: @agent,
        ip: @ip
      })

      # check for successful response
      raise RequestError.new(res) if res.code != "200"
    end

    # returns the value of the subscriber_id cookie
    def subscriber_id
      cookie = @cookies.find{|x| x.start_with? "SUBSCR"}
      cookie.split("=")[1] if cookie
    end

    # returns the value of the session_id cookie
    def session_id
      cookie = @cookies.find{|x| x.start_with? "PHPSESSID"}
      cookie.split("=")[1] if cookie
    end


    def client
      @client ||= Client.new
    end

    def check_mail
      client.get("check_mail")
    end
  end
end
