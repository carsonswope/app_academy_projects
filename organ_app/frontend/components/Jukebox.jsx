var React = require('react');
var TrackStore = require('../stores/TrackStore.js');
var TrackComponent = require('./TrackComponent.jsx');

var Jukebox = React.createClass({

  getInitialState: function() {
    return {tracks: TrackStore.all() };
  },

  componentDidMount: function() {
    TrackStore.addListener(this.updateTracks);
    TrackStore.fetch();
  },

  updateTracks: function() {
    this.setState({tracks: TrackStore.all()});
  },

  render: function(){

    var tracks = this.state.tracks.map(function(track){

      return <TrackComponent key={track.id} track={track} />;

    });

    return(
      <div className='jukebox'>
        Play a saved track:
        {tracks}
      </div>
    );
  }


});

module.exports = Jukebox;
