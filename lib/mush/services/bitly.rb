module Mush
  
  module Services
    
    ## bit.ly and j.mp
    # login=bitlyapidemo
    # apiKey=R_0da49e0a9118ff35f52f629d2d71bf07
    # longUrl=http%3A%2F%2Fbetaworks.com%2F
    # format=json
    # domain=j.mp
    class Bitly < AuthenticatedService
      
      base_uri 'http://api.bit.ly/v3'
      
      def shorten(url)
        invalid_uri_msg = "Please provide a valid URI, including http://"
        invalid_auth_msg = "Invalid Authorization Data, please provide both login and apikey"
        
        raise InvalidURI.new invalid_uri_msg if url.empty?
        raise InvalidAuthorizationData.new(invalid_auth_msg) if login.empty? or apikey.empty?
        
        options = {}
        options[:query] = {:login => self.login, :apiKey => self.apikey, :longUrl => url}
        
        response = get('/shorten', options)
        
        response["status_code"] == 200 ? response["data"]["url"] : response["status_txt"]
      end
      
    end
    
  end
  
end