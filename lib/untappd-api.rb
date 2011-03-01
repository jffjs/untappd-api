require 'httparty'
require 'digest/md5'

module Untappd
  class Base
    include HTTParty
    BASE_URI = 'http://api.untappd.com/v3'
    base_uri BASE_URI

    def initialize(key, user = nil, pass = nil)
      @auth = {}
      if user && pass
        @auth = { :username => user, :password => Digest::MD5.hexdigest(pass) }
      end
      @key = key
    end

    # Get the beer's feed
    # Params: 
    #   :bid => Your API Key provided when you are approved
    #   :since => The numeric ID of the last recent check-in. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def beer_feed(params={})
      get('beer_checkins', params)
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

    # Get the brewery's feed
    # Params: 
    #   :brewery_id => Your API Key provided when you are approved
    #   :since => The numeric ID of the last recent check-in. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def brewery_feed(params={})
      get('brewery_checkins', params)
    end

    # Get extended details for a particular checkin, 
    # which includes location, comments and toasts.
    # Params:
    #   :id => The numeric ID of the check-in.
    def checkin_info(params={})
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

    # Get currently trending beers.
    # Params:
    #   :type => "all", "macro", "micro", "local".  "all" set to default. (Optional)
    #   :limit => The number of records that will return (max 10). (Optional)
    #   :age => "daily", "weekly", "monthly". (Optional)
    #   :geolat =>  The numeric Latitude to filter the public feed. (Optional, required for type "local")
    #   :geolng =>  The numeric Longitude to filter the public feed. (Optional, required for type "local")
    def trending(params={})
      get('trending', params)
    end

    # Get the user information for a selected user.
    # Params:
    #   :user => The username of the person who you wish to obtain the user information. (Optional)
    def user_info(params={})
      get('user', params)
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

    # Get the venue's feed
    # Params: 
    #   :venue_id => Your API Key provided when you are approved
    #   :since => The numeric ID of the last recent check-in. (Optional)
    #   :offset => The offset that you like the dataset to begin with. (Optional)
    def venue_feed(params={})
      get('venue_checkins', params)
    end

    # Get extended information about a venue.
    # Params:
    #   :venue_id => The numeric beer ID of the beer you wish to look up.
    def venue_info(params={})
      get('venue_info', params)
    end

    private

    def get(method, params={})
      path = "/#{method}?key=#{@key}"
      params.each { |k,v| path += "&#{k.to_s}=#{v.to_s}" }

      options = {}
      options.merge({:basic_auth => @auth}) unless @auth.empty?

      response = self.class.get(URI.escape(path), options)
      raise_errors(response)

      response.parsed_response
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
