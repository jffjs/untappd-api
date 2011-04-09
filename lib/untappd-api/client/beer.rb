module Untappd
  class Client
    module Beer
      
      def beer_feed(id, options={})
        query = options.merge(:bid => id)
        API.get('/beer_checkins', query)
      end

      def beer(id)
        query = :bid => id
        API.get('beer_info', query)
      end

      def beer_search(term, options={})
        query = options.merge(:q => term)
        API.get('/beer_search', query)
      end
    end
  end
end

