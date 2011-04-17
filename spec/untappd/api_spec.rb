require 'spec_helper'

describe Untappd::API do
  before do
    @keys = Untappd::Configuration::VALID_OPTIONS_KEYS
  end

  context "with module configuration" do
    
    before do
      Untappd.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key.to_s)
        end
      end
    end

    after do 
      Untappd.reset
    end

    it "should inherit module configuration" do
      api = Untappd::API.new
      @keys.each do |key|
        api.send(key).should == key.to_s
      end
    end

    context "with class configuration" do
      
      before do
        @configuration = {
          :application_key => "AK",
          :endpoint => "http://github.com",
          :user_agent => "Custom User Agent",
          :username => "gambrinus",
          :password => "password"
        }
      end

      context "during initialization" do

        it "should override module configuration" do
          api = Untappd::API.new(@configuration)
          @keys.each do |key|
            api.send(key).should == @configuration[key]
          end
        end
      end

      context "after initialization" do
        
        it "should override module configuration after initialization" do
          api = Untappd::API.new
          @configuration.each do |key, value|
            api.send("#{key}=", value)
          end
          @keys.each do |key|
            api.send(key).should == @configuration[key]
          end
        end
      end
    end
  end
end



