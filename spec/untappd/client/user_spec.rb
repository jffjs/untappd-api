require 'spec_helper'

describe Untappd::Client do
  before do
    @query = { :key => "AK" }
    @checkin_id = "674828"
    @beer_id = "6284"
    @user = "gambrinus"
    @pass = "fake_password"
    @hashed_pass = Digest::MD5.hexdigest(@pass)
    @client = Untappd::Client.new(:application_key => "AK")
  end

  describe ".user_feed" do
  
    context "without authentication" do
    
      before do
        @query.merge!({ :user => @user })
        stub_get("/user_feed").
          with(:query => @query).
          to_return(:body => fixture("user_feed.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.user_feed(:user => @user)
        a_get("/user_feed").
          with(:query => @query).
          should have_been_made
      end

      it "should return up to 25 of the most recent checkins for specified user" do
        checkins = @client.user_feed(:user => @user)
        checkins.should be_an Array
        checkins.first.user.user_name.should == @user
      end
    end

    context "with authentication" do
    
      before do
        @client.username = @user
        @client.password = @pass
        stub_get_with_auth("/user_feed", @user, @hashed_pass).
          with(:query => @query).
          to_return(:body => fixture("user_feed.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.user_feed
        a_get_with_auth("/user_feed", @user, @hashed_pass).
          with(:query => @query).
          should have_been_made
      end

      it "should return up to 25 of the most recent checkins for authenticated user" do
        checkins = @client.user_feed
        checkins.should be_an Array
        checkins.first.user.user_name.should == @user
      end
    end
  end

  describe ".friend_feed" do
    
    before do
      @client.username = @user
      @client.password = @pass
      stub_get_with_auth("/feed", @user, @hashed_pass).
        with(:query => @query).
        to_return(:body => fixture("friend_feed.json"),
                  :headers => { :content_type => "application/json; charset=utf8" } )
    end

    it "should get the correct resource" do
      @client.friend_feed
      a_get_with_auth("/feed", @user, @hashed_pass).
        with(:query => @query).
        should have_been_made
    end

    it "should return up to 25 checkins for authenticated user's friends" do
      checkins = @client.friend_feed
      checkins.should be_an Array
    end
  end

  describe ".user" do

    context "without authentication" do
    
      before do
        @query.merge!({ :user => @user })
        stub_get("/user").
          with(:query => @query).
          to_return(:body => fixture("user.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.user(:user => @user)
        a_get("/user").
          with(:query => @query).
          should have_been_made
      end

      it "should return requested user info" do
        result = @client.user(:user => @user)
        result.user.user_name.should == @user
      end
    end

    context "with authentication" do
      
      before do
        @client.username = @user
        @client.password = @pass
        stub_get_with_auth("/user", @user, @hashed_pass).
          with(:query => @query).
          to_return(:body => fixture("user.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.user
        a_get_with_auth("/user", @user, @hashed_pass).
          with(:query => @query).
          should have_been_made
      end

      it "should return the authenticated user info" do
        result = @client.user
        result.user.user_name.should == @user
      end
    end
  end
  
  describe ".badges" do

    context "without authentication" do
    
      before do
        @query.merge!({ :user => @user })
        stub_get("/user_badge").
          with(:query => @query).
          to_return(:body => fixture("badges.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.badges(:user => @user)
        a_get("/user_badge").
          with(:query => @query).
          should have_been_made
      end

      it "should return the badge info for the requested user" do
        result = @client.badges(:user => @user)
        result.should be_an Array
      end
    end

    context "with authentication" do
    
      before do
        @client.username = @user
        @client.password = @pass

        stub_get_with_auth("/user_badge", @user, @hashed_pass).
          with(:query => @query).
          to_return(:body => fixture("badges.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.badges
        a_get_with_auth("/user_badge", @user, @hashed_pass).
          with(:query => @query).
          should have_been_made
      end

      it "should return the badge info for the authenticated user" do
        result = @client.badges
        result.should be_an Array
      end
    end
  end

  describe ".friends" do

    context "without authentication" do
    
      before do
        @query.merge!({ :user => @user })
        stub_get("/friends").
          with(:query => @query).
          to_return(:body => fixture("friends.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.friends(:user => @user)
        a_get("/friends").
          with(:query => @query).
          should have_been_made
      end

      it "should return the friend info for the requested user" do
        result = @client.friends(:user => @user)
        result.should be_an Array
      end
    end
    
    context "with authentication" do
    
      before do
        @client.username = @user
        @client.password = @pass
        stub_get_with_auth("/friends", @user, @hashed_pass).
          with(:query => @query).
          to_return(:body => fixture("friends.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.friends
        a_get_with_auth("/friends", @user, @hashed_pass).
          with(:query => @query).
          should have_been_made
      end

      it "should return the friend info for the authenticated user" do
        result = @client.friends
        result.should be_an Array
      end
    end
  end

  describe ".wish_list" do

    context "without authentication" do
    
      before do
        @query.merge!({ :user => @user })
        stub_get("/wish_list").
          with(:query => @query).
          to_return(:body => fixture("wish_list.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.wish_list(:user => @user)
        a_get("/wish_list").
          with(:query => @query).
          should have_been_made
      end

      it "should return the wish list for the requested user" do
        result = @client.wish_list(:user => @user)
        result.should be_an Array
      end
    end
    
    context "with authentication" do
    
      before do
        @client.username = @user
        @client.password = @pass
        stub_get_with_auth("/wish_list", @user, @hashed_pass).
          with(:query => @query).
          to_return(:body => fixture("wish_list.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.wish_list
        a_get_with_auth("/wish_list", @user, @hashed_pass).
          with(:query => @query).
          should have_been_made
      end

      it "should return the wish list for the authenticated user" do
        result = @client.wish_list
        result.should be_an Array
      end
    end
  end

  describe ".distinct_beers" do

    context "without authentication" do
    
      before do
        @query.merge!({ :user => @user })
        stub_get("/user_distinct").
          with(:query => @query).
          to_return(:body => fixture("distinct_beers.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.distinct_beers(:user => @user)
        a_get("/user_distinct").
          with(:query => @query).
          should have_been_made
      end

      it "should return up to 25 distinct beers for the requested user" do
        result = @client.distinct_beers(:user => @user)
        result.should be_an Array
      end
    end
    
    context "with authentication" do
    
      before do
        @client.username = @user
        @client.password = @pass
        stub_get_with_auth("/user_distinct", @user, @hashed_pass).
          with(:query => @query).
          to_return(:body => fixture("distinct_beers.json"),
                    :headers => { :content_type => "application/json; charset=utf8" } )
      end

      it "should get the correct resource" do
        @client.distinct_beers
        a_get_with_auth("/user_distinct", @user, @hashed_pass).
          with(:query => @query).
          should have_been_made
      end

      it "should return up to 25 distinct beers for the authenticated user" do
        result = @client.distinct_beers
        result.should be_an Array
      end
    end
  end
end
