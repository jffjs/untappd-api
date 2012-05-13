require 'untappd/error'
require 'untappd/configuration'
require 'untappd/api'
require 'untappd/client'
require 'untappd/version'

# Adapted from Ruby Twitter gem by John Nunemaker
#  @see https://github.com/jnunemaker/twitter
module Untappd
  extend Configuration

  # Alias for Untappd::Client.new
  #
  # @return [Untappd::Client]
  def self.client(options={})
    Untappd::Client.new(options)
  end

  # Delegate to Untappd::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method)
    client.respond_to?(method) || super
  end
end
