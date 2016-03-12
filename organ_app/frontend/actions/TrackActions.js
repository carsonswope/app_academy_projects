var AppDispatcher = require('../dispatcher/Dispatcher.js');
var TrackApiUtil = require('../util/TrackApiUtil.js');

var TrackActions = {

  saveTrack: function(track) {

    TrackApiUtil.postTrack(track);

  },

  removeTrack: function(track) {

    TrackApiUtil.removeTrack(track);

  }


};

module.exports = TrackActions;
