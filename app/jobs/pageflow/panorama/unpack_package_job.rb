module Pageflow
  module Panorama
    class UnpackPackageJob
      @queue = :slow

      extend StateMachineJob

      def self.perform_with_result(package, options)
        JobStatusAttributes.handle(package, stage: :unpacking) do |&progress|
          parse(package)

          package.unpacker.upload(&progress)
          package.attachment_on_filesystem.destroy
        end

        :ok
      end

      private

      def self.parse(package)
        result = Validation.parse(package.archive)

        package.index_document = result.index_document
        package.thumbnail = package.archive.find_entry(result.thumbnail)
      end
    end
  end
end
