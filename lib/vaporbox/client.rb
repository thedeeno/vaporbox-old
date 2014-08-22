require 'uri'
require 'net/http'
require 'json'

module Vaporbox

  # wraps the guerrilla mail service api
  class Client

    # returns the response of GM structured request    #
    def get(function, params={})
      params = params.merge({
        f: function,
        agent: @agent,
        ip: @ip
      })
      uri = URI(@url)
      uri.query = URI.encode_www_form(params)
      req = Net::HTTP::Get.new(uri)
      res = send(req)

      res
    end
    alias :post :get

    private

    # sends a request to the backend api, setting up and capturing
    # required cookies
    def send(req, cookies)
      # add cookies
      req['cookie'] = @cookies.join("; ")

      res = Net::HTTP.start(req.uri.hostname, req.uri.port) {|http|
        http.request(req)
      }

      if res.code == '200' or res.code == '302'
        cookies = res.get_fields('set-cookie')
        # strip text after ; for each cookie
        @cookies = cookies.map{|x| x.split('; ')[0]}
      end

      res
    end
  end
  end
end

