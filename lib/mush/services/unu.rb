module Mush
  
  module Services
    
    class Unu < Service
      base_uri 'http://u.nu/'
      
      def shorten(url)
        raise InvalidURI.new("Please provide a valid URI") if url.empty?
        
        options = {}
        options[:query] = {:url => url}
        get('/unu-api-simple', options).body
      end
      
    end
    
  end
  
end
