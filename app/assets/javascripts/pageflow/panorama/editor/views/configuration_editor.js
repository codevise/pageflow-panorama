pageflow.ConfigurationEditorView.register('panorama', {
  configure: function() {
    var providers = this.options.pageType.providers;

    this.tab('general', function() {
      this.group('general');

      this.input('additional_title', pageflow.TextInputView);
      this.input('additional_description', pageflow.TextAreaInputView, {size: 'short'});
    });

    this.tab('files', function() {
      if (providers.length) {
        this.input('panorama_source', pageflow.SelectInputView, {
          values: ['package', 'url'],
          ensureValueDefined: true
        });
        this.input('panorama_url', pageflow.ProxyUrlInputView, {
          required: true,
          proxies: providers,
          displayPropertyName: 'display_panorama_url',
          visibleBinding: 'panorama_source',
          visibleBindingValue: 'url'
        });
        this.input('panorama_package_id', pageflow.FileInputView, {
          collection: 'pageflow_panorama_packages',
          imagePositioning: false,
          visibleBinding: 'panorama_source',
          visibleBindingValue: 'package'
        });
      }
      else {
        this.input('panorama_package_id', pageflow.FileInputView, {
          collection: 'pageflow_panorama_packages',
          imagePositioning: false
        });
      }

      this.input('thumbnail_image_id', pageflow.FileInputView, {
        collection: pageflow.imageFiles,
        imagePositioning: false
      });
    });

    this.tab('options', function() {
      this.group('options');
    });
  }
});