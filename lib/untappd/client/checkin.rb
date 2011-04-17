module Untappd
  class Client
    module Checkin
      
      # Returns all public checkins, otherwise known as "The Pub".
      #
      # @format :json
      # @authenticated false
      # @option options [String, Integer] :since The ID of the last recent check-in.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @option options [String, Integer] :geolat Latitude to filter results by.
      # @option options [String, Integer] :geolng Longitude to filter results by.
      # @return [Hashie::Mash] The requested beer feed.
      # @example Retrieve the public feed.
      #   Untappd.public_feed
      def public_feed(options={})
        get('thepub', options)
      end

      # Alias for public_feed
      alias_method :the_pub, :public_feed

      # Returns info for the specified checkin.
      #
      # @format :json
      # @authenticated false
      # @param id [String, Integer] The ID of the checkin.
      # @return [Hashie::Mash] The requested checkin.
      # @example Retrieve the checkin with ID 669114 .
      #   Untappd.beer(3839)
      def checkin_details(id)
        options = { :id => id }
        get('details', options)
      end

      # Perform a checkin with the authenticated user.
      #
      # @format :json
      # @authenticated true 
      # @param gmt_offset [String, Integer] The numeric value of hours the user is from GMT (Greenwich Mean Time).
      # @param beer_id [String, Integer] The ID of the beer you wish to check into.
      # @option options [String] :foursquare_id The MD5 hash ID of the Venue you want to attach the beer checkin to.
      # @option options [String] :shout The text you would like included as a comment.  Max of 140 characters.
      # @option options [String, Integer] :rating_value The score you would like to add for the beer.  Must be whole numbers from 1 to 5.
      # @option options [String, Integer] :user_lat Latitude of the user.  Required if you want to add a location to the checkin.
      # @option options [String, Integer] :user_lng Longitude of the user. Required if you want to add a location to the checkin.
      # @option options [String] :facebook Set to "on" to post checkin to Facebook.  Defaults to "off".
      # @option options [String] :twitter Set to "on" to post checkin to Twitter.  Defaults to "off".
      # @option options [String] :foursquare Set to "on" to pass checkin on to Foursquare.  Defaults to "off".
      # @option options [String] :gowalla Set to "on" to pass checkin on to Gowalla.  Defaults to "off".
      # @return [Hashie::Mash] The results of the checkin. Includes info for beer, venue, badges earned, and recommendations.
      # @example Checkin to beer with ID 6284 from Eastern time zone (GMT - 5 hours).
      #   Untappd.checkin(-5, 6284)
      def checkin(gmt_offset, beer_id, options={})
        options.merge!(:gmt_offset => gmt_offset, :bid => beer_id)
        post('checkin', options)
      end
      
      # Add a comment to a checkin.
      #
      # @format :json
      # @authenticated true 
      # @param checkin_id [String, Integer] The ID of the checkin you wish to comment on.
      # @param comment [String] The comment text you would like to add.  Max 140 characters.
      # @return [Hashie::Mash] The results of adding the comment. Includes user and comment details.
      # @example Comment on checkin with ID 669114 and comment text of "Nice."
      #   Untappd.add_comment(669114, "Nice.")
      def add_comment(checkin_id, comment)
        options.merge!(:checkin_id => checkin_id, :comment => comment)
        post('add_comment', options)
      end

      # Delete a comment made by the authenticated user.
      #
      # @format :json
      # @authenticated true 
      # @param comment_id [String, Integer] The ID of the comment you wish to delete.
      # @return [Hashie::Mash] The results of deleting the comment.
      # @example Delete comment with ID 669114.
      #   Untappd.delete_comment(669114)
      def delete_comment(comment_id)
        options.merge!(:comment_id => comment_id)
        post('delete_comment', options)
      end

      # Toast a checkin.
      #
      # @format :json
      # @authenticated true 
      # @param checkin_id [String, Integer] The ID of the checkin you wish to toast.
      # @return [Hashie::Mash] The results of the toast.
      # @example Toast checkin with ID 669114.
      #   Untappd.toast(669114)
      def toast(checkin_id)
        options.merge!(:checkin_id => checkin_id)
        post('toast', options)
      end

      # Remove a toast made by the authenticated user from a checkin.
      #
      # @format :json
      # @authenticated true 
      # @param checkin_id [String, Integer] The ID of the checkin you wish to remove your toast from.
      # @return [Hashie::Mash] The results of the toast removal.
      # @example Remove toast from checkin with ID 669114.
      #   Untappd.remove_toast(669114)
      def remove_toast(checkin_id)
        options.merge!(:checkin_id => checkin_id)
        post('delete_toast', options)
      end
    end
  end
end
