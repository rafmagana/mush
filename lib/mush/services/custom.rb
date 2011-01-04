module Mush
  
  module Services

    # General class to accept a custom shortener
    # e.g. http://short.en?url={{url}}&api_key=982AAJHKDLFDF
    class Custom < Service

      def set_service(service_url)
        @service = service_url
      end

      def shorten(url)
        raise InvalidURI.new("Please provide a valid URI") if url.empty?
        
        options = {}
        path = @service.gsub(/\{url\}/, url) 
        get(path,options).body.chomp
      end  

    end
  
  end

end

