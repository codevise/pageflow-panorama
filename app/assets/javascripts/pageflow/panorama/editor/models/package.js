pageflow.panorama.Package = pageflow.HostedFile.extend({
  processingStages: [
    {
      name: 'unpacking',
      activeStates: ['unpacking'],
      failedStates: ['unpacking_failed']
    }
  ],

  readyState: 'unpacked'
});