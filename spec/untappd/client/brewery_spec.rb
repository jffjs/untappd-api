require 'spec_helper'

describe Untappd::Client do
  before do
    @query = { :key => "AK" }
    @brewery_id = "1142"
    @client = Untappd::Client.new(:application_key => "AK")
  end

  describe ".brewery_feed" do
    
    before do
      @query.merge!({ :brewery_id => @brewery_id })
      stub_get("/brewery_checkins").
        with(:query => @query).
        to_return(:body => fixture("brewery_feed.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.brewery_feed(@brewery_id)
      a_get("/brewery_checkins").
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 25 of the most recent checkins for this brewery" do
      checkins = @client.brewery_feed(@brewery_id)
      checkins.should be_an Array
      checkins.first.brewery_id.should == @brewery_id
    end
  end

  describe ".brewery" do
    
    before do
      @query.merge!({ :brewery_id => @brewery_id })
      stub_get("/brewery_info").
        with(:query => @query).
        to_return(:body => fixture("brewery.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.brewery(@brewery_id)
      a_get("/brewery_info").
        with(:query => @query).
        should have_been_made
    end

    it "should return the requested brewery info" do
      brewery = @client.brewery(@brewery_id)
      brewery.brewery_id.should == @brewery_id
    end
  end

  describe ".brewery_search" do
    
    before do
      @query.merge!({ :q => "brewing" })
      stub_get("/brewery_search").
        with(:query => @query).
        to_return(:body => fixture("brewery_search.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.brewery_search("brewing")
      a_get("/brewery_search").
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 25 search results" do
      results = @client.brewery_search("brewing")
      results.should be_an Array
    end
  end

end

