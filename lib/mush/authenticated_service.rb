module Mush
  
  class AuthenticatedService < Service
    
    attr_accessor :login, :apikey
    
    def initialize
      @login = ''
      @apikey = ''
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