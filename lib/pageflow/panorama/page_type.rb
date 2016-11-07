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
        [
          FileType.new(model: Package,
                       editor_partial: 'pageflow/panorama/editor/packages/package',
                       top_level_type: true)
        ]
      end

      def json_seed_template
        'pageflow/panorama/page_type.json.jbuilder'
      end

      def thumbnail_candidates
        [
          {attribute: 'thumbnail_image_id', file_collection: 'image_files'},
          {attribute: 'panorama_package_id', file_collection: 'pageflow_panorama_packages'}
        ]
      end
    end
  end
end
