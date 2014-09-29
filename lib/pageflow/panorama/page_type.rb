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
                       editor_partial: 'pageflow/panorama/editor/packages/package')
        ]
      end

      def json_seed_template
        'pageflow/panorama/page_type.json.jbuilder'
      end
    end
  end
end
