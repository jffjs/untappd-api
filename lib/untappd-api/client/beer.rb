module Untappd
  class Client
    module Beer
      
      def beer_feed(id, options={})
        query = options.merge(:bid => id)
        get('/beer_checkins', query)
      end

      def beer(id)
        query = :bid => id
        get('beer_info', query)
      end

      def beer_search(term, options={})
        query = options.merge(:q => term)
        get('/beer_search', options)
      end
    end
  end
end

