module Mush

  # This is the class all the services must inherit from.
  class Service
    include HTTParty

    #wrapper for HTTParty.get
    def get(path, options = {})
      self.class.get(path, options)
    end

    def post(path, payload, options = {})
      self.class.post(path, options.merge(:body => payload))
    end

    def shorten(*)
      raise InterfaceMethodNotImplementedError.new("Service#shorten must be overridden in subclasses")
    end

    def authorize(args = {})
      raise InvalidAuthorizationData.new("Invalid Authorization Data, please provide both login and apikey") unless valid_authorization_data? args
      @login = options[:login]
      @apikey = options[:apikey]
    end

    protected
    def valid_authorization_data?(data)
      [:login, :apikey].all? { |key| data.key? key }
    end

    def self.authorizable_with(*options)
      raise InvalidAuthorizationFields.new("Should provide fields to authorize with") if options.empty?
      @params_to_authorize = options
      class_eval do
        options.each { |o| attr_accessor o.to_sym }
      end
    end

  end

end
