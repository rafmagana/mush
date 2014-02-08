require File.expand_path('../helper', __FILE__)

describe Mush do
  describe "Mush::Service class" do
    it "include HTTParty module" do
      assert Mush::Service.include? HTTParty
    end

    it "define a #shorten method" do
      assert Mush::Service.new.respond_to? :shorten
    end

    it "raise and exception if use tries to use #shorten method" do
      assert_raises Mush::InterfaceMethodNotImplementedError do
         Mush::Service.new.shorten
      end
    end

    it "add an instance method called 'get' that wrappes the HTTParty#get method" do
      assert Mush::Service.new.respond_to? :get
    end

    it "add an instance method called 'post' that wrappes the HTTParty#get method" do
      assert Mush::Service.new.respond_to? :post
    end
  end

  describe "All Services" do
    before do
      s = Mush::Services
      @services = [s::IsGd, s::Bitly]
    end

    it "be subclasses of Mush::Service" do
      @services.each do |service|
        assert service < Mush::Service, "#{service} extends Mush::Service"
      end
    end

    it "raise an exception if shorten is called with an empty url" do
      @services.each do |service|
        assert_raises Mush::InvalidURI do
          service.new.shorten('')
        end
      end
    end
  end

  describe "Service" do
    before do
      @long_url = "http://www.a_very_long_url.com"
      @shortened_url = "http://is.gd/test"
      @httparty_response = stub('HTTParty::Response', :body => @shortened_url)
    end

    describe "not authorizable" do
      before do
        @httparty_response = stub('HTTParty::Response', :body => @shortened_url)
        @custom_shortener = 'http://is.gd/api.php?longurl={{url}}'
      end

      describe "IsGd" do

        it "return a shortened url" do
          Mush::Services::IsGd.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(@httparty_response)

          isgd = Mush::Services::IsGd.new
          isgd_result = isgd.shorten(@long_url)

          assert_equal @shortened_url, isgd_result
        end
      end

      describe "Custom" do
        it "return a shortened url" do
          Mush::Services::Custom.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(@httparty_response)

          custom = Mush::Services::Custom.new
          custom.set_service @custom_shortener
          custom_result = custom.shorten(@long_url)

          assert_equal @shortened_url, custom_result
        end
      end
    end

    describe "authorizable" do
      before do
        @response = @shortened_url
      end

      describe "Bitly" do
        it "has authentication credentials to return a shortened url" do

          httparty_response = stub('HTTParty::Response', :[] => @shortened_url)
          bitly = Mush::Services::Bitly.new

          assert_raises Mush::InvalidAuthorizationData do
            bitly.shorten(@long_url)
          end

          bitly.login = "login"
          bitly.apikey = "apikey"

          bitly.shorten(@long_url)

          Mush::Services::Bitly.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(httparty_response)
          assert_equal @shortened_url, bitly.shorten(@long_url)
        end
      end

      describe "Owly" do
        it "has authentication credentials to return a shortened url" do

          httparty_response = stub('HTTParty::Response', :[] => @shortened_url)
          owly = Mush::Services::Owly.new

          assert_raises Mush::InvalidAuthorizationData do
            owly.shorten(@long_url)
          end

          owly.apikey = "apikey"
          owly.shorten(@long_url)

          Mush::Services::Owly.any_instance.stubs(:get).with(instance_of(String), instance_of(Hash)).returns(httparty_response)
        end
      end
    end
  end
end
