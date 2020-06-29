require 'net/http'

module GeoClue
  module ReverseGeocoder
    class << self
      def geocode(coords)
        url = URI::HTTPS.build(
          scheme: "https",
          host: "nominatim.openstreetmap.org",
          path: "/reverse",
          query: URI.encode_www_form(
            format: 'json',
            lat: coords['latitude'],
            lon: coords['longitude']
          )
        )

        result = JSON.parse(Net::HTTP.get(url))

        if result.key?("address")
          result["address"]
        else
          {}
        end
      end
    end
  end
end
