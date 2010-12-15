module Mush
  
  module Services
    
    class Custom < Service

      def set_service(service_url)
        Service::base_uri service_url
      end

      def shorten(url)
        raise InvalidURI.new("Please provide a valid URI") if url.empty?
        
        options = {}
        options[:query] = {:longurl => url}
        get('',options).body.chomp
      end  

    end
  
  end

end

