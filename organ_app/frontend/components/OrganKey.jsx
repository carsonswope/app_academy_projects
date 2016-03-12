var React = require('react');
var Tones = require('../constants/Tones.js');
var Note = require('../util/Note.js');
var KeyStore = require('../stores/KeyStore.js');

var OrganKey = React.createClass({

  getInitialState: function(){
    var playing = KeyStore.all().indexOf(this.props.noteName) > -1;
    return {playing: playing};
  },

  componentDidMount: function(){
    KeyStore.addListener(this.keyStroke);
    var freq = Tones.frequency(this.props.noteName);
    this.note = new Note(freq);
  },

  keyStroke: function(){
    var playing = KeyStore.all().indexOf(this.props.noteName) > -1;
    if (playing !== this.state.playing) {
      this.setState({playing: playing});
      if (this.state.playing) { this.startNote(); }
      else { this.stopNote(); }
    }

  },

  stopNote: function(){
    this.note.stop();
  },

  startNote: function(){
    this.note.start();
  },

  hi: function() {
    debugger;
  },

  render: function(){
    var klass = "organKey";
    if (this.state.playing) {klass += " pressed"; }
    return(<div className={klass} >{this.props.noteName}</div>);
  }

});

module.exports = OrganKey;
