require 'httparty'
require 'hashie'

module Untappd
  class API
    include HTTParty
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Override the password setter in order to MD5 hash the password
    def password=(val)
      @password = Digest::MD5.hexdigest(val) unless val.nil?
    end
    
    # Create a new API
    def initialize(options={})
      options = Untappd.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end

      # Set HTTParty class configurations
      klass = self.class
      klass.base_uri(endpoint)
      klass.default_params(:key => application_key)
      klass.format(:json)
    end

    private
  
    # Wrap calls to the HTTParty get and post methods and return results as Hashie::Mash
    def get(path, options={})
      Hashie::Mash.new(self.class.get(path, build_options(options)).parsed_response)
    end

    def post(path, options={})
      Hashie::Mash.new(self.class.post(path, build_options(options)).parsed_response)
    end

    def build_options(options)
      options = { :query => options }
      if username && password
        options.merge!(:basic_auth => { :username => username, :password => password })
      end

      return options
    end
  end
end
