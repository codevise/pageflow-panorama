module Pageflow
  module Panorama
    module PackagesHelper
      def panorama_url(configuration)
        if configuration['panorama_source'] == 'url'
          configuration['panorama_url']
        else
          package = Package.find_by_id(configuration['panorama_package_id'])
          package ? package.index_document_path : nil
        end
      end
    end
  end
end
