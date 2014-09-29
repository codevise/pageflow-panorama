pageflow.editor.fileTypes.register('pageflow_panorama_packages', {
  model: pageflow.panorama.Package,
  matchUpload: /^application\/zip/
});

pageflow.editor.registerPageConfigurationMixin(pageflow.panorama.configurationMixin);