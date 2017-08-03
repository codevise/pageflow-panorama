module Pageflow
  module Panorama
    module Archive
      def self.for(package)
        tempfile = Paperclip.io_adapters.for(package.attachment)

        begin
          yield(Zip::File.open(tempfile.path))
        ensure
          tempfile.close
          tempfile.unlink
        end
      end
    end
  end
end
