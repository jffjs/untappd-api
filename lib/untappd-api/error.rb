module Untappd
  class Error < StandardError; attr_accessor :code, :type, :detail end

  # Raised when Untappd returns HTTP status code 400
  class BadRequest < Error; end

  # Raised when Untappd returns HTTP status code 401
  class Unauthorized < Error; end

  # Raised when Untappd returns HTTP status code 403
  class General < Error; end

  # Raised when Untappd returns HTTP status code 404
  class NotFound < Error; end

  # Raised when Untappd returns HTTP status code 500
  class InternalError < Error; end

  # Raised when Untappd returns HTTP status code 502
  class BadGateway < Error; end

  # Raised when Untappd returns HTTP status code 503
  class Unavailable < Error; end

  # Raised when Untappd returns HTTP status code 504
  class GatewayTimeout < Error; end
end
