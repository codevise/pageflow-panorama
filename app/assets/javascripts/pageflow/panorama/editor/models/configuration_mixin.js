pageflow.panorama.configurationMixin = {
  getPanoramaUrl: function() {
    if (this.get('panorama_source') === 'url') {
      return this.get('panorama_url');
    }
    else {
      var panoramaPackage = this.getReference('panorama_package_id', 'pageflow_panorama_packages');

      if (panoramaPackage && panoramaPackage.isReady()) {
        return panoramaPackage.get('index_document_path');
      }

      return '';
    }
  }
};