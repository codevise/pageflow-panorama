pageflow.editor.fileTypes.register('pageflow_panorama_packages', {
  model: pageflow.panorama.Package,
  matchUpload: function(upload) {
    return upload.type.match(/^application\/zip/) ||
      upload.name.match(/\.zip$/);
  }
});

pageflow.editor.registerPageConfigurationMixin(pageflow.panorama.configurationMixin);