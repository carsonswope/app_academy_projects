var AppDispatcher = require('../dispatcher/Dispatcher.js');

var TrackApiUtil = {

  postTrack: function(track) {

    var trackParams = {
      name: track.name,
      roll: track.roll
    };

    $.ajax({
      url: "/api/tracks",
      type: "POST",
      data: {track: trackParams},
      success: function(returnTrack) {

        AppDispatcher.dispatch({
          actionType: "ADD_TRACK",
          track: returnTrack
        });

      }
    });
  },

  removeTrack: function(track) {

    $.ajax({
      url: "/api/tracks/" + track.id,
      type: "DELETE",
      success: function() {

        AppDispatcher.dispatch({
          actionType: "REMOVE_TRACK",
          track: track
        });

      }
    });

  },

  getAllTracks: function() {

    $.ajax({
      url: "/api/tracks",
      type: "GET",
      success: function(tracks) {

        AppDispatcher.dispatch({
          actionType: "FETCH_TRACKS",
          tracks: tracks
        });

      }

    });

  }


};

module.exports = TrackApiUtil;
