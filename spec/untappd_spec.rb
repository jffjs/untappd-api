require 'spec_helper'

describe Untappd do

  before do
    @key = "APP_KEY"
    Untappd.configure do |config|
      config.application_key = @key
    end
  end

  after do
    Untappd.reset
  end

  context "when delegating to a client" do
    before do       
      stub_get("/user_feed").
        with(:query => { :key => @key, :user => "gambrinus" }).
        to_return(:body => fixture("user_feed.json"),
                  :headers => { :content_type => "application/json; charset=utf-8" })
    end

    it "should get the correct resource" do
      Untappd.user_feed(:user => "gambrinus")
      a_get("/user_feed").
        with(:query => { :key => @key, :user => "gambrinus" }).
        should have_been_made
    end

    it "should return the same results as a client" do
      Untappd.user_feed(:user => "gambrinus").should == Untappd::Client.new.user_feed(:user => "gambrinus")
    end

    describe ".client" do
      it "should be an Untappd::Client" do
        Untappd.client.should be_a Untappd::Client
      end
    end

    describe ".endpoint" do
      it "should return the default endpoint" do
        Untappd.endpoint.should == Untappd::Configuration::DEFAULT_ENDPOINT
      end
    end

    describe ".endpoint=" do
      it "should set the endpoint" do
        Untappd.endpoint = "http://github.com/"
        Untappd.endpoint.should == "http://github.com/"
      end
    end
  end
end
