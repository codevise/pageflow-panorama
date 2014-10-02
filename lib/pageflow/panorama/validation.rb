module Pageflow
  module Panorama
    module Validation
      def self.parse(archive)
        KrPano.new(archive.entries).parse
      end
    end
  end
end
