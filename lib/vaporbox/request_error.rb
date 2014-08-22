
module Vaporbox
  class RequestError < StandardError
    # TODO: better error message
    def initialize(request, response)
      super("Request failed. #{response.code}")
    end
  end
end
