require 'pageflow/panorama/engine'
require 'pageflow/panorama/version'
require 'pageflow/panorama/configuration'

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

    def self.bucket_factory
      @bucket_factory ||= Panorama::S3Bucket::Factory.new
    end

    def self.bucket_factory=(bucket_factory)
      @bucket_factory = bucket_factory
    end
  end
end
