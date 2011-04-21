module Untappd
  class Client
    module User

      # Returns the feed for the specified user.
      #
      # @format :json
      # @authenticated false unless :name option is omitted.
      # @option options [String] :user The user whose feed you wish to request.  If not provided, the feed of the authenticated user will be returned.
      # @option options [String, Integer] :since The ID of the last recent check-in.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Hashie::Mash] The requested user feed.
      # @example Retrieve the feed for user with username "gambrinus".
      #   Untappd.user_feed(:user => "gambrinus")
      def user_feed(options={})
        get('/user_feed', options)
      end

      # Returns the friend feed for the authenticated user.
      #
      # @format :json
      # @authenticated true
      # @option options [String, Integer] :since The ID of the last recent check-in.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Hashie::Mash] The requested friend feed of the authenticated user.
      # @example Retrieve the friend feed for the authenticated user.
      #   Untappd.friend_feed
      def friend_feed(options={})
        get('/feed', options)
      end

      # Returns the info for the requested user.
      #
      # @format :json
      # @authenticated false unless :user option is omitted.
      # @option options [String] :user The username of the user you wish to request info for.  Returns info for authenticated user if omitted.
      # @return [Hashie::Mash] The requested user info.
      # @example Retrieve the info for the user with username "gambrinus".
      #   Untappd.user(:user => "gambrinus')
      def user(options={})
        get('/user', options)
      end

      # Returns the badge info for the requested user.
      #
      # @format :json
      # @authenticated false unless :user option is omitted.
      # @option options [String] :user The username of the user you wish to request info for.  Returns info for authenticated user if omitted.
      # @return [Hashie::Mash] The badge info for the requested user.
      # @example Retrieve the badge info for the user with username "gambrinus".
      #   Untappd.badges(:user => "gambrinus')
      def badges(options={})
        get('/user_badge', options)
      end

      # Returns the friends for the requested user.
      #
      # @format :json
      # @authenticated false unless :user option is omitted.
      # @option options [String] :user The username of the user you wish to request info for.  Returns info for authenticated user if omitted.
      # @return [Hashie::Mash] The friends of the requested user.
      # @example Retrieve the friends of the user with username "gambrinus".
      #   Untappd.friends(:user => "gambrinus')
      def friends(options={})
        get('/friends', options)
      end

      # Returns the wish list of the requested user.
      #
      # @format :json
      # @authenticated false unless :user option is omitted.
      # @option options [String] :user The username of the user you wish to request info for.  Returns info for authenticated user if omitted.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Hashie::Mash] The wish list of the requested user.
      # @example Retrieve the wish list of the user with username "gambrinus".
      #   Untappd.wish_list(:user => "gambrinus')
      def wish_list(options={})
        get('/wish_list', options)
      end

      # Returns the distinct beers of the requested user.
      #
      # @format :json
      # @authenticated false unless :user option is omitted.
      # @option options [String] :user The username of the user you wish to request info for.  Returns info for authenticated user if omitted.
      # @option options [String, Integer] :offset The offset you would like the dataset to begin with.
      # @return [Hashie::Mash] The distinct beers of the requested user.
      # @example Retrieve the distinct beers of the user with username "gambrinus".
      #   Untappd.distinct_beers(:user => "gambrinus')
      def distinct_beers(options={})
        get('/user_distinct', options)
      end
    end
  end
end
