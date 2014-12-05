require 'pageflow/panorama/engine'

module Pageflow
  module Panorama
    def self.config
      @config ||= Panorama::Configuration.new
    end

    def self.configure(&block)
      block.call(config)
    end

    def self.page_type
      Panorama::PageType.new
    end
  end
end
