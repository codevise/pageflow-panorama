require 'pageflow/panorama/engine'

module Pageflow
  module Panorama
    def self.config
      @config ||= Configuration.new
    end

    def self.configure(&block)
      block.call(config)
    end
  end
end
