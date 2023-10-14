require "logger"
module RubyBolAPI
  class Configuration
    attr_accessor :seller_client_id, :seller_client_secret, :base_url,
                  :api_version, :logger

    def initialize
      @seller_client_id = nil
      @seller_client_secret = nil
      @base_url = base_url || "https://api.bol.com"
      @api_version = api_version || "v10"
      @logger = logger || Logger.new($stdout)
    end
  end
end
