module Untappd
  class Client
    module Brewery

      # Returns the feed for the specified brewery.
      #
      # @format :json
      # @authenticated false
      # @param id [String, Integer] The ID of the brewery.
      # @option options [String, Integer] :since The ID of the last recent check-in.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Array] The requested brewery feed.
      # @example Retrieve the feed for brewery with ID 399.
      #   Untappd.brewery_feed(399)
      def brewery_feed(id, options={})
        options.merge!(:brewery_id => id)
        get('/brewery_checkins', options)
      end

      # Returns info for the specified brewery.
      #
      # @format :json
      # @authenticated false
      # @param id [String, Integer] The ID of the brewery.
      # @return [Hashie::Mash] The requested brewery.
      # @example Retrieve brewery with ID 399.
      #   Untappd.brewery(399)
      def brewery(id)
        options = { :brewery_id => id }
        get('/brewery_info', options)
      end

      # Search breweries with the specified query.
      #
      # @format :json
      # @authenticated false
      # @param query [String] The term that you want to search.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Array] The search results.
      # @example Search breweries for "Bell's".
      #   Untappd.brewery_search("Bell's")
      def brewery_search(query, options={})
        options.merge!(:q => query)
        get('/brewery_search', options)
      end
    end
  end
end
