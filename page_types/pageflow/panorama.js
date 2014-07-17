pageflow.pageType.register('panorama', _.extend({
  enhance: function(pageElement, configuration) {
    pageElement.addClass('hide_content_with_text');

    pageElement.find('.play_button').on('mousedown touchstart', function() {
      pageflow.hideText.activate();
    });

    pageElement.find('.close_button').on('click', function(e) {
      pageflow.hideText.deactivate();
      e.stopPropagation();
    });
  },

  prepare: function(pageElement, configuration) {
    this._ensureIframe(pageElement, configuration);
  },

  preload: function(pageElement, configuration) {
    return pageflow.preload.backgroundImage(pageElement.find('.background_image'));
  },

  activating: function(pageElement, configuration) {
    this._ensureIframe(pageElement, configuration);
  },

  activated: function(pageElement, configuration) {},

  deactivating: function(pageElement, configuration) {},

  deactivated: function(pageElement, configuration) {},

  update: function(pageElement, configuration) {
    pageElement.find('h2 .tagline').text(configuration.get('tagline') || '');
    pageElement.find('h2 .title').text(configuration.get('title') || '');
    pageElement.find('h2 .subtitle').text(configuration.get('subtitle') || '');
    pageElement.find('p').html(configuration.get('text') || '');

    this.updateInfoBox(pageElement, configuration);
    this.updateCommonPageCssClasses(pageElement, configuration);

    pageElement.find('.shadow').css({
      opacity: configuration.get('gradient_opacity') / 100
    });

    if (configuration.hasChanged('panorama_url')) {
      this._ensureIframeCreated(pageElement);
      this.iframe.attr('src', configuration.get('panorama_url'));
    }
  },

  _ensureIframe: function(pageElement, configuration) {
    if (!this.iframe && configuration.panorama_url) {
      this._ensureIframeCreated(pageElement);
      this.iframe.attr('src', configuration.panorama_url);

      $(this.iframe).load(function() {
        $(this).contents().find('body').keydown(function(event) {
          if(event.keyCode == 27) {
            pageflow.hideText.deactivate();
          }
        });
      });
    }
  },

  _ensureIframeCreated: function(pageElement) {
    if (!this.iframe) {
      this.iframe = $('<iframe style="width: 100%; height: 100%; position: absolute; top: 0; left: 0;" name="°" scrolling="no" frameborder="0" align="aus" marginheight="0" marginwidth="0" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>');
      pageElement.find('.iframeWrapper').prepend(this.iframe);
    }
  },

  embeddedEditorViews: function() {
    return {
      '.background_image': {
        view: pageflow.BackgroundImageEmbeddedView,
        options: {propertyName: 'fallback_image_id'}
      }
    };
  }
}, pageflow.commonPageCssClasses, pageflow.infoBox));