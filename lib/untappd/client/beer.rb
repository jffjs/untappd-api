module Untappd
  class Client
    module Beer
      
      # Returns the feed for the specified beer.
      #
      # @format :json
      # @authenticated false
      # @param id [String, Integer] The ID of the beer.
      # @option options [String, Integer] :since The ID of the last recent check-in.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Hashie::Mash] The requested beer feed.
      # @example Retrieve the feed for beer with ID 3839.
      #   Untappd.beer_feed(399)
      def beer_feed(id, options={})
        options.merge!(:bid => id)
        get('/beer_checkins', options)
      end

      # Returns info for the specified beer.
      #
      # @format :json
      # @authenticated false
      # @param id [String, Integer] The ID of the beer.
      # @return [Hashie::Mash] The requested beer.
      # @example Retrieve the beer with ID 3839.
      #   Untappd.beer(3839)
      def beer(id)
        options = { :bid => id }
        get('/beer_info', options)
      end

      # Search beers with the specified query.
      #
      # @format :json
      # @authenticated false
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @option options [String, Integer] :sort Alphabetical order ("name") or checkin count order ("count").
      # @return [Hashie::Mash] The search results.
      # @example Search beers for "Pale ale".
      #   Untappd.beer_search("Pale ale")
      def beer_search(query, options={})
        options.merge!(:q => term)
        get('/beer_search', options)
      end

      # Returns the currently trending beers.
      #
      # @format :json
      # @authenticated false
      # @option options [String] :type "all", "macro", "micro", "local". "all" is set as default.
      # @option options [String, Integer] :limit The number of records to return. (max 10)
      # @option options [String, Integer] :age "daily", "weekly", "monthly".
      # @option options [String, Integer] :geolat Latitude to filter results by. Required when :type => "local".
      # @option options [String, Integer] :geolng Longitude to filter results by. Required when :type => "local".
      # @return [Hashie::Mash] The search results.
      # @example Return all trending beers.
      #   Untappd.trending_beers
      def trending_beers(options={})
        get('/trending', options)
      end
    end
  end
end

