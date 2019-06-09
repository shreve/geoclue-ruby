module GeoClue
  class Config
    attr_accessor :timeout, :format, :skip_cache

    def initialize
      self.timeout = 10
      self.skip_cache = false
    end

    def evaluate(&block)
      return unless block_given?
      instance_eval(&block)
    end

    def inspect
      %i[timeout format skip_cache].each.map do |var|
        "#{var}: #{send(var).inspect}"
      end.join("\n")
    end
  end
end
