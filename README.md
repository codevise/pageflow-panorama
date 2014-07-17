# Pageflow Panorama

Page type showing 360° panoramas in embedded iframes.
Currently supported are panoramas by palmsfilm.com and panogate.com
Accounts for these services are required.

## Installation

### Add pageflow-panorama to your application's Gemfile:

    # Gemfile
    gem 'pageflow-panorama'

bundle install


### Register the page type:

    # config/initializers/pageflow.rb
    Pageflow.configure do |config|
      config.register_page_type(Pageflow::Panorama::PageType.new)
    end

### Include javascripts and stylesheets:

    # app/assets/javascripts/pageflow/application.js
    //= require pageflow/panorama

    # app/assets/javascripts/pageflow/editor.js
    //= require pageflow/panorama/editor

    # app/assets/stylesheets/pageflow/application.scss.css
    @import "pageflow/panorama";


### Create Proxies for the panorama providers:

To circumvent the same-origin policy a proxy from the domain that
serves pageflow to the domain of the panorma-providers has to be
configured.

Example for Nginx:
Copy `config/pageflow-panorama-proxies.conf.example` to your Nginx config
directory, for example `/etc/nginx/pageflow-panorama-proxies.conf`
and include it in you pageflow config file:

     include /etc/nginx/pageflow-panorama-proxies.conf

### Configure the supported panorama providers

If you support both palmfilms and panogate just copy
`config/pageflow_panorama.rb.example` to `config/initializers/pageflow_panorama.rb`
in your app. This sets the `base_path` to correspond with the proxy configuration above.

### Restart the application server.
