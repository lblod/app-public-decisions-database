export default [
  {
    match: {
      subject: {}
    },
    callback: {
      url: "http://resource/.mu/delta",
      method: "POST"
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      subject: {}
    },
    callback: {
      url: 'http://search/update',
      method: 'POST'
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 10000,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      graph: {
        type: 'uri',
        value: 'http://mu.semte.ch/graphs/original-physical-files-data'
      }
    },
    callback: {
      url: 'http://files-consumer/delta',
      method: 'POST'
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 10000,
      ignoreFromSelf: true
    }
  }
];
