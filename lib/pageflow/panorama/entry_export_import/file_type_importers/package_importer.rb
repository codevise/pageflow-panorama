module Pageflow
  module Panorama
    module EntryExportImport
      module FileTypeImporters
        class PackageImporter
          def self.import_file(file_data, _file_mappings)
            Package.create!(file_data.except('id',
                                             'updated_at',
                                             'state',
                                             'unpacking_progress',
                                             'unpacking_error_message'))
          end
        end
      end
    end
  end
end
