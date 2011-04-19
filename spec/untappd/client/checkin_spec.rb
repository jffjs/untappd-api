require 'spec_helper'

describe Untappd::Client do
  before do
    @query = { :key => "AK" }
    @checkin_id = "674828"
    @beer_id = "6284"
    @client = Untappd::Client.new(:application_key => "AK")
  end

  describe ".public_feed" do
    
    before do
      stub_get("/thepub").
        with(:query => @query).
        to_return(:body => fixture("public_feed.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.public_feed
      a_get("/thepub").
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 25 of the most recent checkins" do
      checkins = @client.public_feed
      checkins.should be_an Array
    end
  end

  describe ".checkin_details" do
    
    before do
      @query.merge!({ :id => @checkin_id })
      stub_get("/details").
        with(:query => @query).
        to_return(:body => fixture("checkin_details.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.checkin_details(@checkin_id)
      a_get("/details").
        with(:query => @query).
        should have_been_made
    end

    it "should return requested checkin info" do
      checkin = @client.checkin_details(@checkin_id)
      checkin.checkin_id.should == @checkin_id
    end
  end

  describe ".checkin" do
    
    before do
      @query.merge!({ :bid => @beer_id, :gmt_offset => "-5" })
      stub_post_with_auth("/checkin").
        with(:query => @query).
        to_return(:body => fixture("checkin.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.checkin(@beer_id, -5)
      a_post("/checkin").
        with(:query => @query).
        should have_been_made
    end

    it "should return a successful checkin for the specified beer" do
      result = @client.checkin(@beer_id, -5)
      result.checkin_id.should == @checkin_id
    end
  end

  describe ".add_comment" do
    
    before do
      @query.merge!({ :checkin_id => @checkin_id, :comment => "Test" })
      stub_post_with_auth("/add_comment", "gambrinus", "fake_password").
        with(:query => @query).
        to_return(:body => fixture("add_comment.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should post to the correct resource" do
      @client.add_comment(@checkin_id, "Test")
      a_post("/add_comment").
        with(:query => @query).
        should have_been_made
    end

    it "should return the comment details on success" do
      response = @client.add_comment(@checkin_id, "Test comment")
      response.result.comment_details.comment_text.should == "Test"
    end
  end
end
