module Pageflow
  module Panorama
    class Configuration
      attr_accessor :providers, :packages_base_path

      def initialize
        @providers = []
        @packages_base_path = ''
      end
    end
  end
end
