# Pageflow Panorama

[![Gem Version](https://badge.fury.io/rb/pageflow-panorama.svg)](http://badge.fury.io/rb/pageflow-panorama)
[![Build Status](https://travis-ci.org/codevise/pageflow-panorama.svg?branch=master)](https://travis-ci.org/codevise/pageflow-panorama)

Page type showing 360° panoramas in embedded iframes. Currently
supported are panoramas by palmsfilm.com, panogate.com and KRPano via
upload in the editor.

## Installation

Add pageflow-panorama to your application's Gemfile:

    # Gemfile
    gem 'pageflow-panorama'

and run `bundle install`.

Register the page type:

    # config/initializers/pageflow.rb
    Pageflow.configure do |config|
      config.page_types.register(Pageflow::Panorama.page_type)
    end

Include javascripts and stylesheets:

    # app/assets/javascripts/pageflow/application.js
    //= require pageflow/panorama

    # app/assets/javascripts/pageflow/editor.js
    //= require pageflow/panorama/editor

    # app/assets/stylesheets/pageflow/application.scss
    @import "pageflow/panorama";

    # app/assets/stylesheets/pageflow/editor.scss
    @import "pageflow/panorama/editor";

    # app/assets/stylesheets/pageflow/themes/default.scss
    @import "pageflow/panorama/themes/default";

Install and run migrations:

    $ rake pageflow_panorama:install:migrations
    $ rake db:migrate

### Create Proxies for the Panorama Providers:

To circumvent the same-origin policy, a proxy from the domain that
serves pageflow to the domain of the panorma-providers has to be
configured.

Example for Nginx:
Copy `config/pageflow-panorama-proxies.conf.example` to your Nginx config
directory, for example `/etc/nginx/pageflow-panorama-proxies.conf`
and include it in you pageflow config file:

     include /etc/nginx/pageflow-panorama-proxies.conf

### Configure the Supported Panorama Providers

If you support both palmfilms and panogate just copy
`config/pageflow_panorama.rb.example` to `config/initializers/pageflow_panorama.rb`
in your app. This sets the `base_path` to correspond with the proxy configuration above.

Restart the application server.

## Troubleshooting

If you run into problems while installing the page type, please also
refer to the
[Troubleshooting](https://github.com/codevise/pageflow/wiki/Troubleshooting)
wiki page in the
[Pageflow repository](https://github.com/codevise/pageflow). If that
doesn't help, consider
[filing an issue](https://github.com/codevise/pageflow-panorama/issues).

## Contributing Locales

Edit the translations directly on the
[pageflow-panorama](http://www.localeapp.com/projects/public?search=tf/pageflow-panorama)
locale project.
