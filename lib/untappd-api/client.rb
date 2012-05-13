module Untappd
  
  class Client < API
    require 'untappd-api/client/beer'
    require 'untappd-api/client/brewery'
    require 'untappd-api/client/checkin'
    require 'untappd-api/client/user'
    require 'untappd-api/client/venue'

    include Untappd::Client::Beer
    include Untappd::Client::Brewery
    include Untappd::Client::Checkin
    include Untappd::Client::User
    include Untappd::Client::Venue

  end
end
