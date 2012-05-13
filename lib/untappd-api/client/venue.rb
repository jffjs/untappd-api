module Untappd
  class Client
    module Venue

      # Returns the feed for the specified venue.
      #
      # @format :json
      # @authenticated false       
      # @param id [String, Integer] The ID of the venue.
      # @option options [String, Integer] :since The ID of the last recent check-in.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Array] The requested venue feed.
      # @example Retrieve the feed for venue with ID 12645.
      #   Untappd.venue_feed(399)
      def venue_feed(id, options={})
        options.merge!(:venue_id => id)
        get('/venue_checkins', options)
      end

      # Returns info for the specified venue.
      #
      # @format :json
      # @authenticated false
      # @param id [String, Integer] The ID of the venue.
      # @return [Hashie::Mash] The requested venue.
      # @example Retrieve the venue with ID 12645.
      #   Untappd.venue(12645)
      def venue(id)
        options = { :venue_id => id }
        get('/venue_info', options)
      end
    end
  end
end
