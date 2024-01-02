module Pageflow
  module Panorama
    class PageType < Pageflow::PageType
      name 'panorama'

      def view_helpers
        [
          Pageflow::Panorama::PackagesHelper
        ]
      end

      def file_types
        [Panorama.package_file_type]
      end

      def json_seed_template
        'pageflow/panorama/page_type'
      end

      def thumbnail_candidates
        [
          {
            attribute: 'thumbnail_image_id',
            file_collection: 'image_files'
          },
          {
            attribute: 'panorama_package_id',
            file_collection: 'pageflow_panorama_packages'
          }
        ]
      end
    end

    def self.package_file_type
      FileType.new(model: Package,
                   editor_partial: 'pageflow/panorama/editor/packages/package',
                   top_level_type: true)
    end
  end
end
