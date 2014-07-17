# Pageflow Panorama

Page type showing 360° panoramas in embedded iframes.

## Installation

Add this line to your application's Gemfile:

    # Gemfile
    gem 'pagflow-panorama'

Register the page type:

    # config/initializers/pageflow.rb
    Pageflow.configure do |config|
      config.register_page_type(Pageflow::Panorama::PageType.new)

Include javascripts and stylesheets:

    # app/assets/javascripts/application.js
    //= require "pageflow/panorama"

    # app/assets/javascripts/editor.js
    //= require "pageflow/panorama/editor"

    # app/assets/stylesheets/application.scss.css
    @import "pageflow/panorama"
    
Restart the application server.
