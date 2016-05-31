module Pageflow
  module Panorama
    class Configuration
      DEFAULT_CONTENT_TYPE_MAPPING = {
        'css' => 'text/css',
        'js' => 'application/javascript',
        'html' => 'text/html',
        'csv' => 'text/plain'
      }

      attr_accessor :providers, :packages_base_path

      attr_reader :content_type_mapping

      def initialize
        @providers = []
        @packages_base_path = ''
        @content_type_mapping = DEFAULT_CONTENT_TYPE_MAPPING
      end
    end
  end
end
