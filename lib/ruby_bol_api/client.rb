require "faraday"

module RubyBolAPI
  module Client
    def self.get(endpoint, options = {})
      connection(endpoint, headers: options[:headers]).get
    end

    def self.put(endpoint, data, options = {})
      connection(endpoint, headers: options[:headers]).put { |req| req.body = data }
    end

    def self.post(endpoint, data, options = {})
      connection(endpoint, headers: options[:headers]).post { |req| req.body = data }
    end

    def self.connection(endpoint, options = {})
      default_headers = {
        "Content-Type:" => "application/vnd.retailer.V9+json",
        "Accept:" => "application/vnd.retailer.V9+json",
        "Authorization:" => "Bearer #{Authentication.new.auth_token}"
      }
      Faraday.new(endpoint) do |builder|
        builder.headers = options[:headers] || default_headers
        builder.options.timeout = 10
        builder.request :retry, retry_options
        builder.request :json
        # builder.response :logger, RubyBolAPI.configuration.logger, { headers: true, bodies: true, log_level: :debug }
        builder.response :follow_redirects, limit: 2
        builder.response :json, parser_options: { symbolize_names: true }
      end
    end

    def self.retry_options
      {
        max: 2, interval: 0.05, interval_randomness: 0.5, backoff_factor: 2,
        methods: %i[get put post],
        exceptions: [
          Errno::ETIMEDOUT, Errno::ECONNREFUSED, Errno::EADDRNOTAVAIL,
          Timeout::Error, Faraday::TimeoutError,
          Faraday::ConnectionFailed, Faraday::ResourceNotFound
        ]
      }
    end
  end
end
