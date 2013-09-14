module Mush
  module Services
    class Zaebz < Service
      base_uri 'http://zae.bz'

      def shorten(url)
        if url.empty? || url !~ %r(^https?://.+)
          raise InvalidURI.new("Please provide a valid URI")
        end

        post('/', { :url => url }).body.match(/href="(.+)"/)[1]
      end

    end
  end
end
