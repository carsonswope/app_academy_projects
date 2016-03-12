var React = require('react');

var TrackActions = require('../actions/TrackActions.js');

var TrackComponent = React.createClass({

  playTrack: function() {
    this.props.track.play();
    $('.keyboard').focus();
  },

  deleteTrack: function() {
    TrackActions.removeTrack(this.props.track);
  },

  render: function(){

    return(
      <div>
        {this.props.track.name}
        <button onClick={this.playTrack}> play track </button>
        <button onClick={this.deleteTrack}> delete track </button>
      </div>
    );
  }


});

module.exports = TrackComponent;
