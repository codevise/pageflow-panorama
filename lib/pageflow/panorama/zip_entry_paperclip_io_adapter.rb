require 'zip'
require 'paperclip'

module Pageflow
  module Panorama
    class ZipEntryPaperclipIOAdapter < Paperclip::AbstractAdapter
      # Paperclip < 3.3.1 compatibility
      unless Paperclip::AbstractAdapter.instance_methods.include?(:original_filename=)
        attr_writer(:original_filename)
      end

      def initialize(entry)
        @entry = entry
        cache_current_values
      end

      private

      def cache_current_values
        self.original_filename = @entry.name
        @tempfile = copy_to_tempfile(@entry)
        @content_type = Paperclip::ContentTypeDetector.new(@tempfile.path).detect
        @size = @entry.size
      end

      def copy_to_tempfile(entry)
        override_existing_file = proc { true }
        @entry.extract(destination.path, &override_existing_file)
        destination
      end
    end

    Paperclip.io_adapters.register(ZipEntryPaperclipIOAdapter) do |entry|
      Zip::Entry === entry
    end
  end
end
