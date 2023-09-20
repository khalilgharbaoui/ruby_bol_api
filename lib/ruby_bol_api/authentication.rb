require "base64"
require "zache"

module RubyBolAPI
  class Authentication
    def initialize
      @configuration = RubyBolAPI.configuration
    end

    def auth_token
      get_auth_token
    end

    private

    def get_auth_token
      # https://api.bol.com/retailer/public/Retailer-API/authentication.html#_step_2_acquiring_an_access_token

      auth_url = "https://login.bol.com/token?grant_type=client_credentials"
      credentials = Base64.strict_encode64("#{@configuration.seller_client_id}:#{@configuration.seller_client_secret}")
      headers = {
        "Authorization:" => "Basic #{credentials}",
        "Accept:" => "application/json"
      }

      zache = Zache.new
      response = zache.get(:api_token, lifetime: 299) do
        Client.post(auth_url, headers: headers)
      end

      raise Error, response.body.pretty_inspect unless response.status == 200 && response.body[:access_token]

      response.body[:access_token]
    end
  end
end
