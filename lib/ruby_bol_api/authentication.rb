require "base64"
require "faraday"

module RubyBolAPI
  class Authentication
    def initialize
      @configuration = RubyBolAPI.configuration
      @cache = RubyBolAPI.cache
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
        "Authorization" => "Basic #{credentials}",
        "Accept" => "application/json"
      }

      response = if @cache.exists?(:cached_api_response)
                   @cache.get(:cached_api_response)
                 else
                   # cache the response in memory with a default lifetime
                   @cache.get(:cached_api_response, lifetime: 599) do
                     Faraday.new(auth_url) do |builder|
                       builder.headers = headers
                       builder.request :json
                       builder.response :json, parser_options: { symbolize_names: true }
                     end.post
                   end
                   result = @cache.get(:cached_api_response)
                   # overwrite cache lifetime from response result & return response
                   @cache.put(
                     :cached_api_response,
                     result,
                     lifetime: result.body[:expires_in]
                   )[:value]
                 end

      raise Error, response.body.pretty_inspect unless response.status == 200 && response.body[:access_token]

      response.body[:access_token]
    end
  end
end
