require 'untappd-api'

describe Untappd::Base do
  before do
    @user = "YOUR_USERNAME"
    pass = "YOUR_PASSWORD"
    key = "YOUR_KEY" 
    @client = Untappd::Base.new(@user, pass, key)
  end

  describe "beer_info method" do
    it "should find the correct beer" do
      beer_name = "Hocus Pocus"
      @client.beer_info(:bid => 1).name.should == beer_name
    end

    it "should raise Unauthorized exception with bad parameters" do
      expect {
        @client.beer_info
      }.to raise_exception(Untappd::Unauthorized, /You must provide a beer id to continue/)
    end
  end

  describe "beer_search method" do
    it "should return an Array of search results" do
      @client.beer_search(:q => "Devil").size.should >= 0
    end

    it "should raise Unavailable exception with bad parameters" do
      expect {
        @client.beer_search
      }.to raise_exception(Untappd::Unavailable, /You have not passed anything to search/)
    end
  end

  describe "checkin_details method" do
    it "should return the checkin details for given checkin id" do
      pending("Checkin id is currently not exposed.")
    end

    it "should raise Unauthorized exception with bad parameters" do
      expect {
        @client.checkin_details
      }.to raise_exception(Untappd::Unauthorized, /You must provide a check-in ID to continue/)
    end
  end

  describe "friend_feed method" do
    it "should return the authenticated user's friend feed" do
      @client.friend_feed.size.should >= 0
    end
  end

  describe "public_feed method" do
    it "should return the public feed" do
      @client.public_feed.size.should >= 0
    end
  end

  describe "user method" do
    it "should return the authenticated user if no user specified" do
      @client.user.user_name.should == @user
    end

    it "should return the specified user if user parameter is set" do
      @client.user(:user => "gambrinus").user_name.should == "gambrinus"
    end

    it "should return nil if the specified user is not found" do
      @client.user(:user => ".....").should be_nil
    end
  end

  describe "user_badges method" do
    it "should return the authenticated user's badges" do
      @client.user_badges.size.should >= 0
    end
  end

  describe "user_distinct_beers method" do
    it "should return the authenticated user's distinct beers" do
      @client.user_distinct_beers.size.should >= 0
    end
  end

  describe "user_feed method" do
    it "should return the authenticated user's feed" do
      @client.user_feed.size.should >= 0
    end
  end

  describe "user_friends method" do
    it "should return the authenticated user's friends" do
      @client.user_friends.size.should >= 0
    end
  end

  describe "user_wish_list method" do
    it "should return the authenticated user's wish list" do
      @client.user_wish_list.size.should >= 0
    end
  end
end
