require 'pageflow/panorama/validation'

module Pageflow
  module Panorama
    class UnpackPackageJob
      @queue = :slow

      extend StateMachineJob

      def self.perform_with_result(package, _options)
        JobStatusAttributes.handle(package, stage: :unpacking) do |&progress|
          Archive.for(package) do |archive|
            parse(package, archive)
            unpack_to_s3(package, archive, &progress)
          end
        end

        :ok
      rescue Panorama::Validation::Error
        :error
      end

      private_class_method

      def self.unpack_to_s3(package, archive, &progress)
        bucket = Panorama.bucket_factory.from_attachment(package.attachment_on_s3)

        UnpackToS3
          .new(archive: archive,
               destination_bucket: bucket,
               destination_base_path: package.unpack_base_path,
               content_type_mapping: Panorama.config.content_type_mapping)
          .upload(&progress)
      end

      def self.parse(package, archive)
        result = Validation.parse(archive)

        package.index_document = result.index_document
        package.thumbnail = archive.find_entry(result.thumbnail)
      end
    end
  end
end
