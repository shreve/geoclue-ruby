require 'net/http'

module GeoClue
  module ReverseGeocoder
    class << self
      def geocode(coords)
        url =  "https://locationiq.com/v1/reverse_sandbox.php?format=json&lat=#{coords["latitude"]}&lon=#{coords["longitude"]}"
        uri = URI(url)
        result = Net::HTTP.get(uri)
        JSON.parse(result)["address"]
      end
    end
  end
end
