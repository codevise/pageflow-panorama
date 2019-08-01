pageflow.panorama.Package = pageflow.UploadableFile.extend({
  processingStages: [
    {
      name: 'unpacking',
      activeStates: ['unpacking'],
      failedStates: ['unpacking_failed']
    }
  ],

  readyState: 'unpacked'
});