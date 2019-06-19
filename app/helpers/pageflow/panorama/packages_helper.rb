module Pageflow
  module Panorama
    module PackagesHelper
      include RevisionFileHelper

      def panorama_url(configuration)
        if configuration['panorama_source'] == 'url'
          configuration['panorama_url']
        else
          package = find_file_in_entry(Package, configuration['panorama_package_id'])
          package ? package.index_document_path : nil
        end
      end
    end
  end
end
