module Mush
  
  module Services
    
    class IsGd < Service
      base_uri 'http://is.gd'

      def shorten(url)
        raise InvalidURI.new("Please provide a valid URI") if url.empty?
        
        options = {}
        options[:query] = {:longurl => url}
        get('/api.php', options).body.chomp
      end  

    end
  
  end

end

