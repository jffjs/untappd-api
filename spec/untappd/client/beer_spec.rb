require 'spec_helper'

describe Untappd::Client do
  
  before do
    @query = { :key => "AK" }
    @beer_id = "6284"
    @client = Untappd::Client.new(:application_key => "AK")
  end

  describe ".beer_feed" do
    
    before do
      @query.merge!({ :bid => @beer_id })
      stub_get("/beer_checkins").
        with(:query => @query).
        to_return(:body => fixture("beer_feed.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.beer_feed(@beer_id)
      a_get("/beer_checkins").
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 25 of the most recent checkins for this beer" do
      checkins = @client.beer_feed(@beer_id)
      checkins.should be_an Array
      checkins.first.beer_id.should == @beer_id
    end
  end

  describe ".beer" do
    
    before do
      @query.merge!({ :bid => @beer_id })
      stub_get("/beer_info").
        with(:query => @query).
        to_return(:body => fixture("beer.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.beer(@beer_id)
      a_get("/beer_info").
        with(:query => @query).
        should have_been_made
    end

    it "should return the requested beer info" do
      beer = @client.beer(@beer_id)
      beer.beer_id.should == @beer_id
    end
  end

  describe ".beer_search" do
    
    before do
      @query.merge!({ :q => "pale ale" })
      stub_get("/beer_search").
        with(:query => @query).
        to_return(:body => fixture("beer_search.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.beer_search("pale ale")
      a_get("/beer_search").
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 25 search results" do
      results = @client.beer_search("pale ale")
      results.should be_an Array
    end
  end

  describe ".trending_beers" do
    
    before do
      stub_get("/trending").
        with(:query => @query).
        to_return(:body => fixture("trending_beers.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.trending_beers
      a_get("/trending").
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 10 trending beers" do
      results = @client.trending_beers
      results.should be_an Array
    end
  end
end
