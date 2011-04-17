module Untappd
  
  class Client < API
    require 'untappd/client/beer'
    require 'untappd/client/brewery'
    require 'untappd/client/checkin'
    require 'untappd/client/user'
    require 'untappd/client/venue'

    include Untappd::Client::Beer
    include Untappd::Client::Brewery
    include Untappd::Client::Checkin
    include Untappd::Client::User
    include Untappd::Client::Venue

  end
end
