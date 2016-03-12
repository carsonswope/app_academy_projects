var AppDispatcher = require('../dispatcher/Dispatcher.js');
var TrackApiUtil = require('../util/TrackApiUtil.js');
var Track = require('../util/Track.js');
var Store = require('flux/utils').Store;

var TrackStore = new Store(AppDispatcher);

var _tracks = [];

TrackStore.all = function() {
  return _tracks.slice();
};

TrackStore.fetch = function() {
  TrackApiUtil.getAllTracks();
};

TrackStore.addTrack = function(jsonTrack) {

  var track = new Track(jsonTrack);

  for (var i = 0; i < _tracks.length; i++) {
    if (_tracks[i].id === track.id) { return; }
  }

  _tracks.push(track);
  TrackStore.__emitChange();

};

TrackStore.removeTrack = function(track) {

  var idx = undefined;

  for (var i = 0; i < _tracks.length; i++) {
    if (_tracks[i].id === track.id) { idx = i; }
  }

  if (idx !== undefined) {
    _tracks.splice(idx, 1);
    TrackStore.__emitChange();
  }

};

TrackStore.importTracks = function(jsonTracks) {
  _tracks = jsonTracks.map(function(track){
    return new Track(track);
  });
  TrackStore.__emitChange();
};

TrackStore.__onDispatch = function(payload) {

  switch (payload.actionType) {
    case "ADD_TRACK":
      TrackStore.addTrack(payload.track);
      break;
    case "REMOVE_TRACK":
      TrackStore.removeTrack(payload.track);
      break;
    case "FETCH_TRACKS":
      TrackStore.importTracks(payload.tracks);
      break;
  }
};

module.exports = TrackStore;
