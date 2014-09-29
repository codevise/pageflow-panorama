module Pageflow
  module Panorama
    class Engine < Rails::Engine
      isolate_namespace Pageflow::Panorama

      config.autoload_paths << File.join(config.root, 'lib')
    end
  end
end
