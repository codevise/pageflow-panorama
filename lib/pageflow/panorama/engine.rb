require 'pageflow-public-i18n'
require 'pageflow/panorama/zip_entry_paperclip_io_adapter'

module Pageflow
  module Panorama
    class Engine < Rails::Engine
      isolate_namespace Pageflow::Panorama

      config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.yml').to_s]

      if Rails.respond_to?(:autoloaders)
        lib = root.join('lib')

        config.autoload_paths << lib
        config.eager_load_paths << lib

        initializer 'pageflow_panorama.autoloading' do
          Rails.autoloaders.main.ignore(
            root.join('lib/generators'),
            root.join('lib/pageflow/panorama/configuration.rb'),
            root.join('lib/pageflow/panorama/version.rb'),
            root.join('lib/pageflow/panorama/zip_entry_paperclip_io_adapter.rb')
          )
        end
      else
        config.paths.add('lib', eager_load: true)
      end
    end
  end
end
