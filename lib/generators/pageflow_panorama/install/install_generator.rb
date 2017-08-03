module PageflowPanorama
  class InstallGenerator < Rails::Generators::Base
    desc 'Install the Pageflow plugin and the necessary migrations.'

    def register_plugin
      inject_into_file('config/initializers/pageflow.rb',
                       after: "Pageflow.configure do |config|\n") do

        "  config.page_types.register(Pageflow::Panorama.page_type)\n"
      end
    end

    def install_migrations
      rake "pageflow_panorama:install:migrations"
    end
  end
end
