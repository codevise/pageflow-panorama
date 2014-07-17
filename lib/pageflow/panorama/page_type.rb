module Pageflow
  module Panorama
    class PageType < Pageflow::PageType
      name 'panorama'

      def json_seed_template
        'pageflow/panorama/page_type.json.jbuilder'
      end
    end
  end
end
