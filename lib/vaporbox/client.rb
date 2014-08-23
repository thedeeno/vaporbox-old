require 'uri'
require 'net/http'
require 'json'

module Vaporbox

  # wraps the guerrilla mail service api
  class Client

    def self.start_session
      client = Client.new
      res = client.get("get_email_address")
      sid = JSON.parse(res)["sid_token"]
      Session.new(sid)
    end

    def initialize
      @agent = "vaporbox-gem"
      @ip = "127.0.0.1"
      @url = "http://api.guerrillamail.com/ajax.php"
    end

    # returns the response of GM structured request
    def get(function, params={})
      params = params.merge({
        f: function,
        agent: @agent,
        ip: @ip
      }).reject{|x| x.nil?}

      # encode params in query string
      uri = URI(@url)
      uri.query = URI.encode_www_form(params)

      # create get request
      req = Net::HTTP::Get.new(uri)

      # get response for request
      send(req)
    end

    def post(function, params={})
      params = params.merge({
        f: function,
        agent: @agent,
        ip: @ip
      }).reject(&:nil?)

      # setup post request
      uri = URI(@url)
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(params)

      # get response for request
      send(req)
    end

    private

    # sends a request to the backend api, setting up and capturing
    # required cookies
    def send(req)
      # # add cookies
      # req['cookie'] += "SUBSCR=#{subscription_id}; " unless subscription_id.nil?
      # req['cookie'] += "PHPSESSID=#{session_id}; " unless session_id.nil?

      Net::HTTP.start(req.uri.hostname, req.uri.port) {|http|
        http.request(req)
      }
    end

    # extracts the value of cookie with given key
    def extract_cookie_value(cookies, key)
      # strip text after ; for each cookie
      cookies = cookies.map{|x| x.split('; ')[0]}
      cookie = cookies.find{|x| x.start_with? "#{key}="}
      if cookie.nil?
        return nil
      else
        return cookie.split("=")[1]
      end
    end
  end
end

