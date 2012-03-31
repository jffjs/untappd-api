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
      handle_error(response)
      Hashie::Mash.new(response).results
    end

    def post(path, options={})
      response = @klass.post(path,  :body => options,
                                    :basic_auth => auth)
      handle_error(response)
      Hashie::Mash.new(response)
    end

    def auth
      if username && password
        { :username => username, 
          :password => Digest::MD5.hexdigest(password) }
      end
    end

    def handle_error(response)
      message = response['error']

      case response['http_code']
        when 400
          raise BadRequest, message
        when 401
          raise Unauthorized, message
        when 403
          raise General, message
        when 404
          raise NotFound, message
        when 500
          raise InternalError, message
        when 502
          raise BadGateway, message
        when 503
          raise Unavailable, message
        when 504
          raise GatewayTimeout, message
      end
    end
  end
end
