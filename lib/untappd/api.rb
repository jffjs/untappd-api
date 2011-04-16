require 'httparty'

module Untappd
  class API
    include HTTParty
    base_uri endpoint
    default_params :key => application_key
    basic_auth username, password
    format :json

  end
end
