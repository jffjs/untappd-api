require 'hashie'

module Untappd
  
  class Client
    require 'untappd/client/beer'


    include Untappd::Client::Beer

    private

    # Return results as a Hashie::Mash
    def get(path, options)
      Hashie::Mash.new(API.get(path, :query => options))
    end

    def post(path, options)
      Hashie::Mash.new(API.post(path, :query => options))
    end
  end
end
