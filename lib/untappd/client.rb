module Untappd
  
  class Client < API
    require 'untappd/client/beer'


    include Untappd::Client::Beer

  end
end
