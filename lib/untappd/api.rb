require 'httparty'
require 'hashie'

module Untappd
  class API
    include HTTParty
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Override these setters so that HTTParty class methods get updated as well
    def endpoint=(val)
      @endpoint = val
      @klass.base_uri(endpoint)
    end

    def application_key=(val)
      @application_key = val
      @klass.default_params(:key => application_key)
    end
    
    # Create a new API
    def initialize(options={})
      @klass = self.class
      options = Untappd.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key]) 
      end

      # Set HTTParty class configurations
      @klass.format(:json)
    end

    private
  
    # Wrap calls to the HTTParty get and post methods and return results as Hashie::Mash
    def get(path, options={})
      response = @klass.get(path, :query => options,
                                  :basic_auth => auth).parsed_response
      Hashie::Mash.new(response).results
    end

    def post(path, options={})
      response = @klass.post(path,  :body => options,
                                    :basic_auth => auth).parsed_response
      Hashie::Mash.new(response)
    end

    def auth
      if username && password
        { :username => username, 
          :password => Digest::MD5.hexdigest(password) }
      end
    end
  end
end
