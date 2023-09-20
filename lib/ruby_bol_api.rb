# frozen_string_literal: true

require_relative "ruby_bol_api/version"
require_relative "ruby_bol_api/configuration"
require_relative "ruby_bol_api/authentication"
require_relative "ruby_bol_api/client"
require_relative "ruby_bol_api/error"

module RubyBolAPI
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end