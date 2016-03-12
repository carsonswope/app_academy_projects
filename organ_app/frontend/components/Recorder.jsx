var React = require('react');
var Track = require('../util/Track.js');
var KeyStore = require('../stores/KeyStore.js');
var TrackActions = require('../actions/TrackActions.js');

var Recorder = React.createClass({

  getInitialState: function(){
    return {
      isRecording: false,
      track: new Track({}),
      trackName: ''
    };
  },

  componentDidMount: function(){
    KeyStore.addListener(this.keyChange);
  },

  keyChange: function(){
    this.state.track.addNotes(KeyStore.all());
  },

  record: function(){
    if (this.state.track.recording) {
      this.state.track.stopRecording();
      this.forceUpdate();
    } else {
      $('.keyboard').focus();
      this.state.track.startRecording();
      this.forceUpdate();
    }
  },

  playTrack: function(){
    this.state.track.play();
    $('.keyboard').focus();
  },

  saveTrack: function(){

    this.state.track.name = this.state.trackName;
    TrackActions.saveTrack(this.state.track);
    this.resetTrack();
  },

  resetTrack: function(){
    this.setState({track: new Track({}), trackName: ''});
    this.forceUpdate();
  },

  nameInput: function(e) {
    this.setState({trackName: e.target.value});
  },

  render: function(){

    var buttonType = this.state.track.recording ? "stop-recording" : "start-recording";
    var buttonText = this.state.track.recording ? "stop recording" : "start recording";

    var otherButtons = <div></div>;

    if (!this.state.track.recording && this.state.track.roll.length) {
      otherButtons =
        <span>
          <div className="btn" id="play-button"  onClick={this.playTrack}>play</div>
          <div className="btn" id="save-button"  onClick={this.saveTrack}>save</div>
          <div className="btn" id="reset-button" onClick={this.resetTrack}>reset</div>
        </span>;
    } else {
      otherButtons =
        <span>
          <span className="btn" id={buttonType} onClick={this.record}></span>
          <span className="btn-text"> {buttonText}</span>
        </span>;
    }

    return(
      <div className="recorder">
        <div className="name-input">

          <div id="track-name-label">track name</div>

          <input id="track-name-input"
            type="text"
            onChange={this.nameInput}
            value={this.state.trackName}>
          </input>

        </div>

        {otherButtons}
      </div>
    );

  }

});

module.exports = Recorder;
