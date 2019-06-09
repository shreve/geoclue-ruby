require 'dbus'

module GeoClue
  class Client
    COORD_KEYS = %w[latitude longitude accuracy].freeze
    ADDR_KEYS = %w[house_number road city county state country postcode country_code].freeze

    def initialize
      @data = {}
    end

    def full_location
      coordinates.merge(address)
    end

    def coordinates(skip_cache: GeoClue.config.skip_cache)
      return cache.coordinates if !skip_cache && cache.has_coordinates?

      client.Start
      start = Time.now
      loop do
        sleep 0.1
        break if @data.key?("accuracy") and @data["accuracy"] < 500
        break if Time.now - start > GeoClue.config.timeout
      end

      result = @data.slice(*COORD_KEYS)
      raise "Unable to find location" if result.empty?

      cache.save(@data)
      result
    end

    def address(skip_cache: GeoClue.config.skip_cache)
      return cache.address if !skip_cache && cache.has_address?

      addr = ReverseGeocoder.geocode(coordinates).slice(*ADDR_KEYS)
      cache.save(addr)
      addr
    end

    def cache
      @cache ||= Cache.new
    end

    def service
      @service ||= DBus.system_bus["org.freedesktop.GeoClue2"]
    end

    def manager
      @manager ||= begin
                     object = service["/org/freedesktop/GeoClue2/Manager"]
                     interface = object["org.freedesktop.GeoClue2.Manager"]
                     object
                   end
    end

    def client_id
      @client_id ||= manager.CreateClient
    end

    def client
      @client ||= begin
                    object = service[client_id]
                    interface = object["org.freedesktop.GeoClue2.Client"]
                    interface["DesktopId"] = "geoclue-ruby"
                    interface["RequestedAccuracyLevel"] = ['u', 8]
                    interface.on_signal("LocationUpdated") do
                      handle_location_update(interface["Location"])
                    end
                    Thread.new { interface["Location"] }
                    object
                  end
    end

    def handle_location_update(location_id)
      location = service[location_id]
      interface = location["org.freedesktop.GeoClue2.Location"]
      @data = location.GetAll("org.freedesktop.GeoClue2.Location").transform_keys(&:downcase)
    end
  end
end
