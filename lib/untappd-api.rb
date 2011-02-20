require 'httparty'
require 'hashie'
require 'digest/md5'

Hash.send :include, Hashie::HashExtensions

module Untappd
  class Base
    include HTTParty
    BASE_URI = 'http://api.untappd.com/v2'
    base_uri BASE_URI

    def initialize(user, pass, key)
      @auth = { :username => user, :password => Digest::MD5.hexdigest(pass) }
      @key = key
    end

    # Get extended information about a beer.
    # Params:
    #   :bid => The numeric beer ID of the beer you wish to look up.
    def beer_info(params={})
      get('beer_info', params)
    end

    # Get a list of matching beers.
    # Params:
    #   :q => Name of the beer you wish to search for.
    def beer_search(params={})
      get('beer_search', params)
    end

    # Get extended details for a particular checkin, 
    # which includes location, comments and toasts.
    # Params:
    #   :id => The numeric ID of the check-in.
    def checkin_details(params={})
      get('details', params)
    end

    # Get the friend check-in feed of the authenticated user.
    # Params:
    #   :since => The numeric ID of the last recent check-in. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def friend_feed(params={})
      get('feed', params)
    end

    # Get the public feed for Untappd.
    # Params:
    #   :latitude =>  The numeric Latitude to filter the public feed. (Optional)
    #   :longitude =>  The numeric Longitude to filter the public feed. (Optional)
    #   :since => The numeric ID of the last recent check-in. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def public_feed(params={})
      get('thepub', params)
    end

    # Get the user information for a selected user.
    # Params:
    #   :user => The username of the person who you wish to obtain the user information. (Optional)
    def user(params={})
      result = get('user', params)
      result.user unless result.nil?
    end

    # Get a list of the user's badges.
    # Params: 
    #   :user => The username of the person who you wish to obtain the user information. (Optional)
    #   :sort => Filters the badge list by type: "beer", "venue", or "special". (Optional)
    def user_badges(params={})
      get('user_badge', params)
    end

    # Get the user's distinct beers.
    # Params:
    #   :user => The username that you wish to call the request upon. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def user_distinct_beers(params={})
      get('user_distinct', params)
    end

    # Get the friend check-in feed of the selected user. 
    # Params:
    #   :user => The username that you wish to call the request upon. (Optional)
    #   :since => The numeric ID of the last recent check-in. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def user_feed(params={})
      get('user_feed', params)
    end

    # Get a list of the user's friends.
    # Params:
    #   :user => The username that you wish to call the request upon. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def user_friends(params={})
      get('friends', params)
    end

    # Get the user's wish listed beers.
    # Params:
    #   :user => The username that you wish to call the request upon. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def user_wish_list(params={})
      get('wish_list', params)
    end

    private

    def get(method, params={})
      path = "/#{method}?key=#{@key}"
      params.each { |k,v| path += "&#{k.to_s}=#{v.to_s}" }

      options = {:basic_auth => @auth}
      response = self.class.get(URI.escape(path), options)
      raise_errors(response)

      response.parsed_response.to_mash.results 
    end

    def raise_errors(response)
      message = "#{response.body} - #{BASE_URI}#{response.request.path}"

      case response.code
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
        when 501..503
          raise Unavailable, message
      end
    end
  end

  class BadRequest    < StandardError; end
  class Unauthorized  < StandardError; end
  class General       < StandardError; end
  class Unavailable   < StandardError; end
  class InternalError < StandardError; end
  class NotFound      < StandardError; end
end
