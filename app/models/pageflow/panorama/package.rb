require 'zip'

module Pageflow
  module Panorama
    class Package < ActiveRecord::Base
      include HostedFile

      processing_state_machine do
        state 'unpacking'
        state 'unpacked'
        state 'unpacking_failed'

        event :process do
          transition any => 'unpacking'
        end

        event :retry do
          transition 'unpacking_failed' => 'unpacking'
        end

        before_transition on: :retry do |package|
          JobStatusAttributes.reset(package, stage: :unpacking)
        end

        job UnpackPackageJob do
          on_enter 'unpacking'
          result :ok, state: 'unpacked'
          result :error, state: 'unpacking_failed'
        end
      end

      has_attached_file(:thumbnail, Pageflow.config.paperclip_s3_default_options
                          .merge(default_url: ':pageflow_placeholder',
                                 default_style: :thumbnail,
                                 styles: Pageflow.config.thumbnail_styles))

      def thumbnail_url(*args)
        thumbnail.url(*args)
      end

      def index_document_path
        if attachment_on_s3.present? && index_document
          File.join(Panorama.config.packages_base_path, unpack_base_path, index_document)
        end
      end

      def unpack_base_path
        attachment_on_s3.present? ? File.dirname(attachment_on_s3.path(:unpacked)) : nil
      end
    end
  end
end
