module Pageflow
  module Panorama
    class S3Bucket
      attr_reader :bucket

      def initialize(bucket)
        @bucket = bucket
      end

      def write(name:, input_stream:, content_length:, content_type:)
        object = bucket.objects[name]
        object.write(input_stream,
                     acl: :public_read,
                     content_type: content_type,
                     content_length: content_length)
      end

      class Factory
        def from_attachment(attachment)
          S3Bucket.new(attachment.s3_bucket)
        end
      end
    end
  end
end
