require 'zip'

module Pageflow
  module Panorama
    class UnpackToS3
      attr_reader :archive, :destination_bucket, :destination_base_path,
                  :content_type_mapping

      def initialize(options)
        @archive = options.fetch(:archive)
        @destination_bucket = options.fetch(:destination_bucket)
        @destination_base_path = options.fetch(:destination_base_path)
        @content_type_mapping = options.fetch(:content_type_mapping, {})
      end

      def upload(&progress)
        archive.entries.each_with_index do |entry, index|
          yield(100.0 * index / archive.entries.size) if block_given?
          upload_entry(entry)
        end
      end

      private

      def upload_entry(entry)
        return unless entry.file?
        with_retry do
          s3_object(entry.name).write(entry.get_input_stream,
                                      acl: :public_read,
                                      content_length: entry.size,
                                      content_type: content_type_for(entry.name))
        end
      end

      def s3_object(file_name)
        destination_bucket.objects[destination_path(file_name)]
      end

      def destination_path(file_name)
        File.join(destination_base_path, file_name)
      end

      def content_type_for(file_name)
        content_type_mapping[File.extname(file_name).delete('.')]
      end

      def with_retry(&block)
        retries = 0

        begin
          yield
        rescue AWS::S3::Errors::SlowDown
          retries += 1

          if retries <= 5
            sleep((2 ** retries) * 0.5)
            retry
          else
            raise
          end
        end
      end
    end
  end
end
