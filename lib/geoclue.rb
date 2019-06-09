require "geoclue/version"
require "geoclue/cache"
require "geoclue/config"
require "geoclue/client"
require "geoclue/reverse_geocoder"

module GeoClue
  class << self
    def coordinates
      client.coordinates
    end

    def address
      client.address
    end

    def full_location
      client.full_location
    end

    def client
      @client ||= Client.new
    end

    def config(&block)
      @config ||= Config.new
      @config.evaluate(&block)
      @config
    end
  end
end
