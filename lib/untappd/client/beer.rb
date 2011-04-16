module Untappd
  class Client
    module Beer
      
      # @param id [String] The ID of the beer.
      # @option options [String] since The ID of the last recent check-in.
      # @option options [String] offset The offset you would like the dataset to begin with.
      def beer_feed(id, options={})
        options.merge!(:bid => id)
        get('/beer_checkins', options)
      end

      # @param id [String] The ID of the beer.
      def beer(id)
        options = { :bid => id }
        get('beer_info', options)
      end

      # @param query [String] The term that you want to search.
      # @option options [String] offset The offset you would like the dataset to begin with.
      # @option options [String] sort Alphabetical order ("name") or checkin count order ("count").
      def beer_search(query, options={})
        options.merge!(:q => term)
        get('/beer_search', options)
      end

    end
  end
end

