require 'bundler/setup'
require 'untappd'
require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

def a_get(path)
  a_request(:get, Untappd.endpoint + path)
end

def a_post(path)
  a_request(:post, Untappd.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Untappd.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Untappd.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
