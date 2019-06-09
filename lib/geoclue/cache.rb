require 'json'

module GeoClue
  class Cache
    attr_accessor :data

    def initialize
      @data = {}
      read if valid?
    end

    def read
      @data = JSON.parse(File.read(filepath))
    end

    def save(data)
      @data.merge!(data)
      write!
    end

    def write!
      File.write(filepath, JSON.dump(@data))
    end

    def coordinates
      @data.slice(*Client::COORD_KEYS)
    end

    def address
      @data.slice(*Client::ADDR_KEYS)
    end

    def has_coordinates?
      valid? and Client::COORD_KEYS.all? { |key| @data.key?(key) }
    end

    def has_address?
      valid? and Client::ADDR_KEYS.all? { |key| @data.key?(key) }
    end

    def valid?
      exists? and recent? and full?
    end

    def exists?
      File.exist?(filepath)
    end

    def recent?
      (Time.now - File.mtime(filepath)) < 600
    end

    def full?
      File.stat(filepath).size > 0
    end

    def filepath
      File.expand_path(
        File.join(
          ENV.fetch('XDG_CACHE_HOME',
                    File.join(ENV.fetch('HOME', '~/'),'.cache')),
          'geoclue-cache.json'
        )
      )
    end
  end
end
