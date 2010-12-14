module Mush
  
  module Services
    
  require 'json'
    ## ow.ly
    # apiKey=L6jj368UlrsrkCKxeLXUZ
    # longUrl=http%3A%2F%2Fbetaworks.com%2F
    # format=json
    # domain=j.mp
    class Owly < AuthenticatedService
      
      base_uri 'http://ow.ly/api/1.1/url'
      format :json

      #Ow.ly api bug, response is in json, but response type is html so force parse
      def self.response_parse
        Proc.new do |body, format|
          JSON.parse(body)
        end
      end
      parser response_parse
        
      def shorten(url)
        invalid_uri_msg = "Please provide a valid URI, including http://"
        invalid_auth_msg = "Invalid Authorization Data, please provide apikey"
        
        raise InvalidURI.new invalid_uri_msg if url.empty?
        raise InvalidAuthorizationData.new(invalid_auth_msg) if apikey.empty?
        
        options = {:format => 'json'}
        options[:query] = {:apiKey => self.apikey, :longUrl => url}
        
        response = get('/shorten', options)
      
        response.code == 200 ? response["results"]["shortUrl"] : response["error"]
      end
      
    end
    
  end
  
end
