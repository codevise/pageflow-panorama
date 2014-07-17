module Pageflow
  module Panorama
    class Configuration
      attr_accessor :providers

      def initialize
        @providers = []
      end
    end
  end
end
