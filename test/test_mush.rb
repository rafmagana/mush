require 'helper'

class TestMush < Test::Unit::TestCase

  context "Mush::Service class" do
    should "include HTTParty module" do
      assert Mush::Service.include? HTTParty
    end
    
    should "define a #shorten method" do
      assert Mush::Service.new.respond_to? :shorten
    end
    
    should "raise and exception if use tries to use #shorten method" do
      assert_raise Mush::InterfaceMethodNotImplementedError do
         Mush::Service.new.shorten
      end
    end
    
    should "add an instance method called 'get' that wrappes the HTTParty#get method" do
      assert Mush::Service.new.respond_to? :get
    end
  end
  
  context "All Services" do
    setup do
      s = Mush::Services
      @services = [s::IsGd, s::Bitly, s::Unu]
    end
    
    should "be subclasses of Mush::Service" do
      @services.each do |service|
        assert Mush::Service, service.superclass
      end
    end
      
    should "raise an exception if shorten is called with an empty url" do
      @services.each do |service|
        assert_raise Mush::InvalidURI do
          service.new.shorten('')
        end
      end
    end
    
  end
  
  context "Service" do
    setup do
      @long_url = "http://www.a_very_long_url.com"
      @shortened_url = "http://is.gd/test"
      @httparty_response = stub('HTTParty::Reponse', :body => @shortened_url)
    end
    
    context "not authorizable" do

      setup do
        @httparty_response = stub('HTTParty::Reponse', :body => @shortened_url)
        @custom_shortener = 'http://is.gd/api.php?longurl={{url}}'
      end
    
      context "IsGd" do
      
        should "return a shortened url" do
          Mush::Services::IsGd.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(@httparty_response)
      
          isgd = Mush::Services::IsGd.new      
          isgd_result = isgd.shorten(@long_url)
      
          assert_equal @shortened_url, isgd_result
        end
      end

      context "Unu" do
        should "return a shortened url" do
          Mush::Services::Unu.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(@httparty_response)
    
          unu = Mush::Services::Unu.new
          unu_result = unu.shorten(@long_url)
    
          assert_equal @shortened_url, unu_result
        end
      end

      context "Custom" do
        should "return a shortened url" do
          Mush::Services::Custom.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(@httparty_response)

          custom = Mush::Services::Custom.new
          custom.set_service @custom_shortener
          custom_result = custom.shorten(@long_url)

          assert_equal @shortened_url, custom_result
        end
      end
    end

    context "authorizable" do
      setup do
        @response = @shortened_url
      end
      
      context "Bitly" do
        should "has authentication credentials to return a shortened url" do
          
          httparty_response = stub('HTTParty::Response', :[] => @shortened_url)
          bitly = Mush::Services::Bitly.new
          
          assert_raise Mush::InvalidAuthorizationData do
            bitly.shorten(@long_url)
          end
          
          bitly.login = "login"
          bitly.apikey = "apikey"

          assert_nothing_raised do
            bitly.shorten(@long_url)
          end
          
          Mush::Services::Bitly.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(httparty_response)
          assert_equal @shortened_url, bitly.shorten(@long_url)
        end
      end

      context "Owly" do
        should "has authentication credentials to return a shortened url" do

          httparty_response = stub('HTTParty::Response', :[] => @shortened_url)
          owly = Mush::Services::Owly.new

          assert_raise Mush::InvalidAuthorizationData do
            owly.shorten(@long_url)
          end

          owly.apikey = "apikey"

          assert_nothing_raised do
            owly.shorten(@long_url)
          end

          Mush::Services::Bitly.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(httparty_response)
        end
      end
    end
  end
end
