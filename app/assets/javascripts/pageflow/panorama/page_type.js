pageflow.pageType.register('panorama', _.extend({
  enhance: function(pageElement, configuration) {
    var that = this;

    pageElement.addClass('hide_content_with_text');

    pageElement.find('.play_button').on('click', function() {
      pageflow.hideText.activate();
    });

    pageElement.find('.close_button').on('click', function(e) {
      pageflow.hideText.deactivate();
      e.stopPropagation();
    });

    this.removeUnplayedClass = function() {
      pageElement.find('.content_and_background').removeClass('unplayed');
    };

    this.enableScrollIndicator = function() {
      that.scrollIndicator.enable();
    };
  },

  prepare: function(pageElement, configuration) {
    this._ensureIframe(pageElement, configuration);
  },

  preload: function(pageElement, configuration) {
    return pageflow.preload.backgroundImage(pageElement.find('.background_image'));
  },

  activating: function(pageElement, configuration) {
    this._ensureIframe(pageElement, configuration);
    pageElement.find('.content_and_background').addClass('unplayed');
  },

  activated: function(pageElement, configuration) {
    pageflow.hideText.on('activate', this.removeUnplayedClass);
    pageflow.hideText.on('deactivate', this.enableScrollIndicator);
  },

  deactivating: function(pageElement, configuration) {
    pageflow.hideText.off('activate', this.removeUnplayedClass);
    pageflow.hideText.off('deactivate', this.enableScrollIndicator);
  },

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

    if (this.panoramaUrl !== configuration.getPanoramaUrl()) {
      this.panoramaUrl = configuration.getPanoramaUrl();

      this._ensureIframeCreated(pageElement);
      this.iframe.attr('src', this.panoramaUrl);
    }
  },

  _ensureIframe: function(pageElement, configuration) {
    if (!this.iframe) {
      var panoramaUrl = pageElement.find('.iframeWrapper').data('panoramaUrl');

      if (panoramaUrl) {
        this._ensureIframeCreated(pageElement);
        this.iframe.attr('src', panoramaUrl);

        $(this.iframe).load(function() {
          $(this).contents().find('body').keydown(function(event) {
            if(event.keyCode == 27) {
              pageflow.hideText.deactivate();
            }
          });
        });
      }
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