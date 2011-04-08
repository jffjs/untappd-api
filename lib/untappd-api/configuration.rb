# Adapted from the Ruby Twitter gem.
# @see https://github.com/jnunemaker/twitter
module Untappd
  module Configuration
    VALID_OPTIONS_KEYS = [
          :application_key,
          :endpoint,
          :user_agent
    ].freeze

    DEFAULT_APPLICATION_KEY = nil.freeze

    DEFAULT_ENDPOINT = "http://api.untappd.com/v3".freeze

    DEFAULT_USER_AGENT = "untappd-api Ruby Gem #{Untappd::VERSION}".freeze

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # When this module is extended, set all configuration options to their default values.
		def self.extended(base)
			base.reset
		end

    # Convenience method to allow configuration options to be set in a block.
		def configure
			yield self
		end

    # Create a hash of options and their values.
		def options
			Hash[VALID_OPTIONS_KEYS.map { |key | [key, send(key)] }]
		end

    # Reset configuration options to default
    def reset
      self.application_key  = DEFAULT_APPLICATION_KEY
      self.endpoint         = DEFAULT_ENDPOINT
      self.user_agnet       = DEFAULT_USER_AGENT
    end
  end
end