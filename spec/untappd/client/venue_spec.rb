require 'spec_helper'

describe Untappd::Client do
  before do
    @query = { :key => "AK" }
    @venue_id = "14411"
    @client = Untappd::Client.new(:application_key => "AK")
  end

  describe ".venue_feed" do
    
    before do
      @query.merge!({ :venue_id => @venue_id })
      stub_get("/venue_checkins").
        with(:query => @query).
        to_return(:body => fixture("venue_feed.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.venue_feed(@venue_id)
      a_get("/venue_checkins").
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 25 of the most recent checkins for this venue" do
      checkins = @client.venue_feed(@venue_id)
      checkins.should be_an Array
      checkins.first.venue_id.should == @venue_id
    end
  end

  describe ".venue" do
    
    before do
      @query.merge!({ :venue_id => @venue_id })
      stub_get("/venue_info").
        with(:query => @query).
        to_return(:body => fixture("venue.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.venue(@venue_id)
      a_get("/venue_info").
        with(:query => @query).
        should have_been_made
    end

    it "should return the requested venue info" do
      venue = @client.venue(@venue_id)
      venue.internal_venue_id.should == @venue_id
    end
  end
end
